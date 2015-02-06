#! /usr/bin/env perl

use strict;
use Data::Dumper;
use File::Basename;
use lib dirname (__FILE__);
use DT;

my $usage = "Usage: $0 combined.vcf.list\n\n";

my $vcf_list_file = shift @ARGV or die $usage;
my $show_html = 1;

my @vcfs = map { chomp; my @cols = split/\t/;
                 push @cols, undef while @cols < 18;
                 \@cols;
           } `cat $vcf_list_file`;
# print STDERR '\@vcfs = '. Dumper(\@vcfs);

my %groups;
my %seen;

for (@vcfs) {
    my ($strain, $sample, $pos) = @$_;
    # my $var_key = join(":", $contig, $pos);
    my $var_key = $pos;
    push @{$groups{$var_key}}, $_ if !$seen{$var_key}->{$strain}++;
}

# print STDERR '\%groups = '. Dumper(\%groups);

my @snps;
for my $k (sort keys %groups) {
    my $var = $groups{$k}->[0];
    $var->[0] = join(",", map { $_->[0] } @{$groups{$k}});
    $var->[6] = sprintf("%.1f", mean(map { $_->[6] } @{$groups{$k}}));
    $var->[7] = sprintf("%.2f", mean(map { $_->[7] } @{$groups{$k}}));
    push @snps, $var;
}


@snps = sort { $a->[2] <=> $b->[2] } @snps;

# print STDERR '\@vars = '. Dumper(\@vars);

if ($show_html) {
    # my @head = ('Strain', 'Sample', 'Pos', 'Ref', 'Var', 'Score', 'Var cov', 'Var frac',
    my @head = ('Strain', 'Contig', 'Pos', 'Ref', 'Var', 'Flanking primers', 'Var cov', 'Var frac',
                'Type', 'Ref nt', 'Var nt', 'Ref aa', 'Var aa',
                'Gene ID', 'Gene', 'Ref frame',
                "Neighboring feature (3' end)",
                "Neighboring feature (5' end)" );
    my @rows;
    for (@snps) {
        my $minor = 1 if $_->[5] < 10 || $_->[6] < 5 || $_->[7] < 0.5;
        my $major = 1 if $_->[0] eq 'FTS-634,NR-643';
        $_->[0] = DT::span_css($_->[0], "bold") if $major;
        $_->[1] = 'NC_006570';
        # $_ = [@$_[0..4,6..17]],
        $_->[5] = add_link("primers", "http://bioseed.mcs.anl.gov/~fangfang/francisella/primers/primers_RD_" . $_->[2] . ".html");
        my @c =
            # map { DT::span_css($_, 'wrap') }
                map { $minor ? DT::span_css($_, "opaque") : $_ }
                map { ref $_ eq 'ARRAY' ? $_->[0] ? linked_gene(@$_) : undef : $_ }
                map { $_ ? $_ : '&nbsp;' }
                map { /^\s*:\s*$/ ? undef : $_ }
                    @$_;
        push @rows, \@c;
    }
    DT::print_dynamic_table(\@head, \@rows, { title => 'SNPs', extra_css => extra_css() });
} else {
    for (@snps) {
        my @c = map { ref $_ eq 'ARRAY' ? $_->[0] ? $_->[1] : undef : $_ } @$_;
        print join("\t", @c) . "\n";
    }
}

sub linked_gene {
    my ($url, $txt) = @_;
    $txt ||= $url;
    return $txt;
}

sub add_link {
    my ($txt, $url) = @_;
    return "<a href=\"$url\">$txt</a>";
}

sub extra_css {
    return <<End_of_CSS;
<style type="text/css">
  .opaque {
      opacity:0.50;
  }
  .bold {
      font-weight: bold;
  }
  .highlight {
    text-decoration:underline;
  }
</style>
End_of_CSS
}

sub mean {
    my @x = @_;
    my $n = @x;
    my $s;
    $s += $_ for @x;
    return $s/$n;
}
