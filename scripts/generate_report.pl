#! /usr/bin/env perl

use strict;
use Carp;
use Data::Dumper;
use File::Basename;

my $usage = "Usage: $0 args\n\n";

my $name = 'Francisella tularensis Schu S4';
my @list = get_isolates();
my %dict = get_SRR_to_isolate_mapping();

my $base = dirname(__FILE__) . "/..";
my $n_proteins_in_ref = 2031;

for (@list) {
    my ($isolate, $runs) = @$_;
    print "## $name $isolate\n\n";
    printf "This isolate has one NCBI assembly and %d sequence runs: ", scalar@$runs;
    print join(", ", @$runs)."\n\n";

    print "### $isolate scaffolds\n\n";

    print "#### Contig alignment (ref vs NCBI scaffolds)\n\n";
    print "![$isolate contig alignment](http://bioseed.mcs.anl.gov/~fangfang/francisella/png/$isolate.png)\n\n";

    print "#### SNPs (ref vs NCBI scaffolds)\n\n";
    print_dnadiff_snp_text($isolate);

    print "#### DNA differences (ref vs NCBI scaffolds)\n\n";
    print_report_dnadiff_text("$base/olive-mummer/$isolate/$isolate.report");

    for my $srr (@$runs) {
        print "### $srr\n\n";

        print "#### Contig alignment (ref vs de novo assembly)\n\n";
        print "![$srr contig alignment](http://bioseed.mcs.anl.gov/~fangfang/francisella/png/$srr.png)\n\n";

        print "#### SNPs (ref vs reads)\n\n";
        print_snp_text($srr);

        print "#### DNA differences (ref vs de novo assembly)\n\n";
        print_dnadiff_text($srr);

        print "#### Protein differences (ref vs de novo assembly)\n\n";
        print_bbh_text($srr);

    }
}


sub print_bbh_text { 
    my ($srr) = @_; 
    my ($ndiff) = `wc -l $base/bbhs/$srr.bbhs` =~ /(^\d+)/;
    my $ratio = sprintf "%.2f", 100 * $ndiff / $n_proteins_in_ref; 
 
    print "$ndiff of the $n_proteins_in_ref proteins (".$ratio."%) in the reference genome have Bidirectional Best Hits (BBHs) in the de novo assembled contigs from $srr reads.\n\n"; 
 
    print "The protein pairs with low coverage (< 90%) or imperfect identity scores are listed below. Also listed are proteins unique to either genome.\n\n";
 
    my $file = "$base/bbhs/$srr.diffs"; 
    # print table_to_html($file)."\n";
    print table_to_markdown($file)."\n"; 
}

sub print_dnadiff_text {
    my ($srr) = @_;
    my $file = "$base/mummer/$srr/$srr.report";
    my $text = `head -n 19 $file |tail -n 16`;
    $text =~ s/      \[QRY\]/\[$srr\]/;
    print "```\n$text```\n";
}

sub print_report_dnadiff_text {
    my ($report) = @_;
    my $name = $report; $name =~ s/.*\///; $name =~ s/\.report//;
    my $text = `head -n 19 $report |tail -n 16`;
    $text =~ s/      \[QRY\]/\[$name\]/;
    print "```\n$text```\n";
}

sub print_dnadiff_snp_text {
    my ($name) = @_;
    my $file = "$base/olive-mummer/$name/$name.snps";
    my $text = `cat $file`;
    print "```\n$text```\n";
}

sub print_snp_text {
    my ($srr) = @_;
    my $file = "$base/snps/$srr.snps";
    print table_to_markdown($file)."\n";
    # print table_to_html($file)."\n";
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
        s/%2C/,/g;
        push @out, $_;
    }
    return join("", @out);
}

sub table_to_html {
    my ($table) = @_;
    return "None\n" unless -s $table;

    my ($header, @lines) = `cat $table`;
    return "None\n" if @lines <= 1;

    my @out;
    push @out, "<table>";
    my @cols = split(/\t/, $header);
    push @out, "<tr>".join('', map { "<th>$_</th> " } @cols)."</tr>";
    for (@lines) {
        s/kb\|//g;
        s/%2C/,/g;
        my @cols = split/\t/;
        push @out, "<tr>".join('', map { "<td>$_</td> " } @cols)."</tr>";
    }
    push @out, "</table>";
    return join("\n", @out);
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
FSC043	SRR999318
