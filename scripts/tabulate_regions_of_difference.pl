#! /usr/bin/env perl

use strict;

my $usage = "Usage: $0 [-maf mugsy.maf] [-ref org] org1.fa org2.fa ...\n\n";

# reference in the middle:
# scripts/tabulate_regions_of_difference.pl -maf mugsy/all.maf olive/SL.scaffolds.fasta olive/NR-10492.scaffolds.fasta olive/NR-28534.scaffolds.fasta olive/FSC043.scaffolds.fasta ref/AJ749949.contigs olive/FTS-634.scaffolds.fasta olive/NR-643.scaffolds.fasta  -sort AJ749949 FTS-634 NR-643 FSC043 NR-28534 NR-10492 SL

# reference on the left:
# scripts/tabulate_regions_of_difference.pl -maf mugsy/curated.all.maf ref/AJ749949.contigs olive/FSC043.scaffolds.fasta olive/NR-10492.scaffolds.fasta olive/NR-28534.scaffolds.fasta olive/SL.scaffolds.fasta olive/FTS-634.scaffolds.fasta olive/NR-643.scaffolds.fasta -sort AJ749949 FTS-634 NR-643 FSC043 NR-28534 NR-10492 SL >va.txt

use gjoseqlib;
use Data::Dumper;
use Getopt::Long;

my ($help, $maf, $ref, $context, @org_sort);

GetOptions("h|help"  => \$help,
           "maf=s"   => \$maf,
           "ref=s"   => \$ref,
           "c=i"     => \$context,
           "sort=s{,}" => \@org_sort,
	  ) or die("Error in command line arguments\n");

$help and die $usage;

my @orgs = @ARGV or die $usage;

$context ||= 3;

my $orgH = get_org_contigs(@orgs);
# print STDERR '$orgH = '. Dumper($orgH);

my @blocks = get_maf($maf, $orgH);
# print STDERR '$blocks = '. Dumper(\@blocks);
# exit;
@blocks = sort { cmp_blocks($a, $b, \@org_sort) } @blocks;
# @blocks = sort @blocks;
# print STDERR '$blocks = '. Dumper(\@blocks);

$ref ||= ($org_sort[0] || $orgs[0]);
$ref = org_to_name($ref);

for my $block (@blocks) {
    my $i;
    my $start = $block->{$ref}->{start}; # in: 0-based
    my %beg;
    for (@orgs) {
        my $name = org_to_name($_);
        $beg{$name} = $block->{$name}->{start};
    }
    my %ctg;
    for (@orgs) {
        my $name = org_to_name($_);
        $ctg{$name} = $block->{$name}->{contigNo};
    }
    while (1) {
        my $refbase = substr($block->{$ref}->{seq}, $i, 1);
        $start++ if $refbase =~ /[ATGCN]/; # 1-based 
        my $coord = $start;
        $coord = $coord .  ($refbase eq '-' ? '*' : ' ');
        $coord = sprintf "%8s", $coord;
        my @cols; 
        my @cols2;
        my $nongap;
        my $ambig;
        my %seen;
        for (@orgs) {
            my $name = org_to_name($_);
            my $base = substr($block->{$name}->{seq}, $i, 1);
            if ($base) {
                $ambig++ if $base eq 'N';
                if ($base ne 'N' && $base ne '-') {
                    $seen{$base}++;
                    $nongap++;
                }
            } else {
                $base = ' ';                
            }
            push @cols, $base;

            if ($name ne $ref) {
                $beg{$name}++ if $base =~ /[ATGCN]/; # 1-based 
                my $co;
                $co = "$ctg{$name}_" . $beg{$name} if $base ne ' ';
                $co .= $base eq '-' ? '*' : ' ';
                $co = sprintf "%10s", $co;
                # $co = sprintf "%17s", "$name:$co";
                push @cols2, $co;
            }
        }
        last unless $nongap || $ambig;
        $i++;
        my $flag;
        $flag = 'IND' if $nongap > 0 && $nongap < @orgs;
        $flag = 'SNP' if keys %seen > 1;
        # print join("\t", $coord, @cols, $flag, join(",", @cols2)) . "\n";
        print join("\t", $coord, @cols, $flag, @cols2) . "\n";
    }
    print "\n";
}

sub get_coordinate_for_block {
    my ($block, $org_sort, $i) = @_;
    
}

sub cmp_blocks {
    my ($b1, $b2, $org_sort) = @_;
    my $rv = 0;
    for (@$org_sort) {
        my $org = $_;
        $org =~ s|.*/||; $org =~ s/\..*$//; $org =~ s/-/_/g;
        my $n1 = $b1->{$org}->{contigNo}; $n1 = 999999 unless defined($n1);
        my $n2 = $b2->{$org}->{contigNo}; $n2 = 999999 unless defined($n2);
        my $s1 = $b1->{$org}->{start}; $s1 = 999999999999 unless defined($s1);
        my $s2 = $b2->{$org}->{start}; $s2 = 999999999999 unless defined($s2);
        $rv = ($n1 <=> $n2 || $s1 <=> $s2);
        # print join("  ", $rv, $b1->{$org}->{contigNo}, $b2->{$org}->{contigNo}, $b1->{$org}->{start}, $b2->{$org}->{start}) . "\n";
        last if $rv;
    }
    return $rv;
}


sub get_maf {
    my ($maf, $orgH) = @_;
    my @lines = `cat $maf`;
    my @blocks;
    my $line;
    while ($line = shift @lines) {
        next unless $line =~ /^a score/;
        my %block;
        while ($line = shift @lines) {
            my $block;
            last if $line !~ /^s /;
            # MAF format: http://genome.ucsc.edu/FAQ/FAQformat.html#format5
            my ($flag, $src, $start, $size, $strand, $srcSize, $seq) = split(/\s+/, $line);
            my ($org, $contig) = split(/\./, $src);
            $block{$org} = { src => $src, start => $start, size => $size, strand => $strand,
                             srcSize => $srcSize,
                             seq => $seq,
                             org => $org, contig => $contig,
                             contigNo => $orgH->{$org}->{$contig}->[0],
                             contigLen => $orgH->{$org}->{$contig}->[1] };
        }
        push @blocks, \%block;
    }
    wantarray ? @blocks : \@blocks;
}



sub get_org_contigs {
    my @orgs = @_;
    my %hash;
    for my $f (@orgs) {
        my $org = $f; $org =~ s|.*/||; $org =~ s/\..*$//; $org =~ s/-/_/g;
        my $i = 0; 
        my %dict = map { $_->[0] => [ ++$i, $_->[1] ] }
                   sort { $b->[1] <=> $a->[1] }
                   map { [ $_->[0], length $_->[2] ] } gjoseqlib::read_fasta($f);

        $hash{$org} = \%dict;
    }
    wantarray ? %hash : \%hash;
}

sub org_to_name {
    my ($org) = @_;
    $org =~ s|.*/||; $org =~ s/\..*$//; $org =~ s/-/_/g;
    return $org;
}
