#! /usr/bin/env perl

use strict;
use Carp;
use Data::Dumper;

my $usage = "Usage: $0 SRR_ID.contigs.fa\n\n";

my $name = 'Francisella tularensis Schu S4';
my %dict = get_SRR_to_isolate_mapping();

my $fasta = shift @ARGV or die $usage;
my ($srr) = $fasta =~ /(SRR\d+)/; $srr or die $usage;
my $isolate = $dict{$srr};
$name .= " $isolate";

run("rast2-create-genome --scientific-name '$name' --genetic-code 11 --domain Bacteria --contigs $fasta > $srr.gto");
run("rast2-process-genome < $srr.gto > $srr.gto2");
run("rast2-export-genome protein_fasta < $srr.gto2 > $srr.faa");


sub get_SRR_to_isolate_mapping {
    my %dict = map { chomp; my ($isolate, $srr) = split /\t/; $srr => $isolate } <DATA>;
    return %dict;
}

sub run { system(@_) == 0 or confess("FAILED: ". join(" ", @_)); }


__END__
FSC043	SRR1061345
FSC043	SRR999318
FTS-634	SRR1061346
FTS-634	SRR999319
NR-10492	SRR1061347
NR-10492	SRR999320
NR-28534	SRR1061348
NR-28534	SRR999321
NR-643	SRR1019709
NR-643	SRR999322
SL	SRR1061349
SL	SRR999323
