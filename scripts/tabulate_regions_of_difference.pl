#! /usr/bin/env perl

use strict;

my $usage = "Usage: $0 [-maf mugsy.maf] [-ref org] org1.fa org2.fa ...\n\n";

# scripts/tabulate_regions_of_difference.pl -maf mugsy/all.maf olive/SL.scaffolds.fasta olive/NR-10492.scaffolds.fasta olive/NR-28534.scaffolds.fasta olive/FSC043.scaffolds.fasta ref/AJ749949.contigs olive/FTS-634.scaffolds.fasta olive/NR-643.scaffolds.fasta  -sort AJ749949 FTS-634 NR-643 FSC043 NR-28534 NR-10492 SL

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
print STDERR '$blocks = '. Dumper(\@blocks);

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
                             # seq => $seq,
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


