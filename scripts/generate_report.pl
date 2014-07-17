#! /usr/bin/env perl

use strict;
use Carp;
use Data::Dumper;
use File::Basename;

my $usage = "Usage: $0 args\n\n";

my $name = 'Francisella tularensis Schu S4';
my @list = get_isolates();

my $base = dirname(__FILE__) . "/..";

for (@list) {
    my ($isolate, $runs) = @$_;
    print "## $name $isolate\n\n";
    printf "This isolate has %d sequence runs: ", scalar@$runs;
    print join(", ", @$runs)."\n\n";
    for my $srr (@$runs) {
        print "### $srr\n\n";

        print "#### Contig alignment\n\n";
        print "![$srr contig alignment](http://bioseed.mcs.anl.gov/~fangfang/francisella/png/$srr.png)\n\n";

        print "#### SNPs\n\n";
        print_snp_text($srr);
        
        print "#### DNA differences\n\n";

        print "#### Protein differences\n\n";
        print_bbh_text($srr);

    }
}

sub print_snp_text {
    my ($srr) = @_;
    my $file = "$base/snps/$srr.snps";
    print table_to_markdown($file)."\n";
}

sub print_bbh_text {
    my ($srr) = @_;
    my $file = "$base/bbhs/$srr.diffs";
    print table_to_markdown($file)."\n";
}


sub table_to_markdown {
    my ($table) = @_;
    return "None\n" unless -s $table;

    my ($header, @lines) = `cat $table`;
    return "None\n" if @lines <= 1;
    
    my @cols = split(/\t/, $header);
    my $separator = join("\t", ('---') x scalar@cols)."\n";
    my @out;
    for ($header, $separator, @lines) {
        s/\t/ \| /g;
        s/kb\|//g;
        push @out, $_;
    }
    return join("", @out);
}

sub get_isolates {
    my @lines = <DATA>;
    my %seen;
    my %hash;
    my @list;
    for (@lines) {
        chomp;
        my ($isolate, $srr) = split /\t/;
        push @{$hash{$isolate}}, $srr;
        push @list, $isolate if !$seen{$isolate}++;
    }
    @list = map { [ $_, $hash{$_} ] } @list;
    return @list;
}

sub get_SRR_to_isolate_mapping {
    my %dict = map { chomp; my ($isolate, $srr) = split /\t/; $srr => $isolate } <DATA>;
    return %dict;
}

sub run { system(@_) == 0 or confess("FAILED: ". join(" ", @_)); }

# TODO: add FSC043	SRR1061345

__END__
FSC043	SRR999318
FTS-634	SRR999319
FTS-634	SRR1061346
NR-10492	SRR999320
NR-10492	SRR1061347
NR-28534	SRR999321
NR-28534	SRR1061348
NR-643	SRR999322
NR-643	SRR1019709
SL	SRR999323
SL	SRR1061349
