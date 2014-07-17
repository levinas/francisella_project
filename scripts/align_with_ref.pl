#! /usr/bin/env perl

use strict;
use Carp;
use Cwd 'abs_path';

my $usage = "Usage: $0 SRR_ID.contigs.fa ref.fa\n\n";

my $qry = shift @ARGV;
my $ref = shift @ARGV;

$qry && $ref or die $usage;

$qry = abs_path($qry);
$ref = abs_path($ref);

my $qry_name = clean_name($qry);
my $ref_name = clean_name($ref);

my $dir = $qry_name;
my $pre = $qry_name;

run("mkdir -p $dir");
chdir($dir);


run("dnadiff -p $pre $ref $qry");

# http://mummer.sourceforge.net/manual/
run("show-coords -rcl $pre.delta > $pre.coords");
# run("show-aligns $pre.delta $ref_name $qry_name > $pre.aligns");
run("mummerplot $pre.delta -p $pre -R $ref -Q $qry --filter --layout --png");


sub run { system(@_) == 0 or confess("FAILED: ". join(" ", @_)); }

sub clean_name {
    my ($name) = @_;
    $name =~ s/.*\///;
    $name =~ s/\.(fasta|fna|fa)//;
    $name =~ s/\.contigs//;
    $name;
}
