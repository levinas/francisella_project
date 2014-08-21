#! /usr/bin/env perl

use strict;
use Data::Dumper;

my $usage = "Usage: $0 vertical_alignment.txt\n\n";

my $va = shift @ARGV or die $usage;

my $context = 3;
my $collapse = 1;
my $annoF = 'RD_annotation.txt';

my %annoH = map { chomp; my ($loc, $desc, $link) = split/\t/;
                  $loc => rast_href($desc, $link) } `cat $annoF`;

print STDERR '\%annoH = '. Dumper(\%annoH);

my @orgs = qw(AJ749949 FSC043 NR-10492 NR-28534 SL FTS-634 NR-643);

my $title  = "Regions of differences";
my $js     = mouseover_javascript();
my $legend = html_legend();
my $css    = html_css();
my @rows   = get_rows();
my $body   = join("\n", @rows);

print <<"End_of_Page";
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<title>$title</title>
$css
</head>
<body>
$js
<pre>
$body
$legend
</pre>
</body>
</html>
End_of_Page

sub base_class {
    my ($base) = @_;
    return $base =~ /[ATCG]/ ? '.' :
           $base eq 'N'      ? '-' : $base;
}

sub get_rows {
    my @rows;
    push @rows, "<pre>";
    my @lines = `grep -P '(IND|SNP)' -C $context $va`;

    my $k;
    my @mark;
    if ($collapse) {
        for (@lines) {
            my @c = split /\t/;
            $k++;
            next unless $c[8] eq 'IND';
            my $m = base_class($c[1]);
            for (my $i = 2; $i <= 7; $i++) {
                $m .= base_class($c[$i]);
            }
            $mark[$k] = $m;
        }
    }

    my $k = 1;
    my $n_hidden = 0;
    push @rows, 'AJ749949 REF     FSC043    NR-10492   NR-28534          SL    FTS-634     NR-643    Type';
    push @rows, '----------------------------------------------------------------------------------------';
    for (@lines) {
        
        my $hidden = 1;
        for (my $d = -$context; $d <= $context; $d++) {
            my $j = $k + $d;
            if ($j < 1 || $j > @lines || !$mark[$j] || !$mark[$k] || $mark[$j] ne $mark[$k]) {
                $hidden = 0; last;
            } 
        }
        $k++;
        if ($hidden) {
            $n_hidden++;
            # push @rows, 'hidden';
            next;
        }

        if ($n_hidden) {
            my $m = $mark[$k-1];
            my @d;
            my $base = substr($m, 0, 1); 
            my $coord;
            $coord = '...' if $base ne ' ';
            $coord .= $base eq '-' ? '*' : ' ';
            $coord = sprintf("%8s", $coord);
            push @d, span_css($coord, 'grey');
            push @d, span_css($base, 'bold')."  ";
            for (my $i = 1; $i <= 6; $i++) {
                my $bs = substr($m, $i, 1); 
                my $co;
                $co = '...' if $bs ne ' ';
                $co .= $bs eq '-' ? '*' : ' ';
                $co = sprintf("%10s", $co);
                if ($base eq '.' && $bs ne '.') {
                    $bs = span_css($bs, 'del');
                } elsif ($base ne '.' && $bs eq '.') {
                    $bs = span_css($bs, 'ins');
                }
                push @d, span_css($co, 'coord').' '.$bs;
            }
            push @d, "    ". span_css("IND", 'grey'). span_css(" $n_hidden lines", 'coord');
            my $row = join(" ", @d);
            push @rows, $row;
            $n_hidden = 0;
        }

        chomp;
        my @c = split /\t/;
        my @d; 
        push @d, span_css($c[0], 'grey');
        push @d, span_css($c[1], 'bold')."  ";
        my $type = $c[8];
        for (my $i = 2; $i <= 7; $i++) {
            my $coord = $c[$i+7];
            my $indel;
            my $base = $c[$i];
            if ($type eq 'SNP' && $c[$i] ne $c[1]) {
                $base = span_css($c[$i], 'snp');
            }
            if ($c[1] =~ /[ATCG]/ && $c[$i] !~ /[ATCG]/) {
                $base = span_css($c[$i], 'del');
            } elsif ($c[1] !~ /[ATCG]/ && $c[$i] =~ /[ATCG]/) {
                $base = span_css($c[$i], 'ins');
            }
            push @d, span_css($coord, 'coord').' '.$base;
        }
        push @d, "    ".$type;

        my $anno;
        my @locs = @c[0, 9..14];
        for (my $i = 0; $i < 7; $i++) {
            my $org = $orgs[$i];
            my $loc = $locs[$i];
            $loc =~ s/\s+//g;
            my $desc = $annoH{"$org:$loc"};
            # print STDERR "$org:$loc";
            # print STDERR "\t$desc\n";
            $anno .= " $desc" if $desc;
        }

        my $row = join(" ", @d);
        $row .= "       $anno" if $anno;
        $row = span_css($row, 'snp_row') if $type eq 'SNP';
        push @rows, $row;
    }
    push @rows, '----------------------------------------------------------------------------------------';
    push @rows, 'AJ749949 REF     FSC043    NR-10492   NR-28534          SL    FTS-634     NR-643    Type';

    push @rows, "</pre>";
    return @rows;
}

sub html_legend {
}

sub html_css {
    my $css_main       = css_snippet_main();
    my $css_auxilary   = css_snippet_auxilary();

    my @lines = map { css_from_hash($_) } ($css_main, $css_auxilary);

    return join("\n", @lines). "\n";
}

sub css_snippet_main {
    { pre => { 'font-size'   => '12px',
               'font-family' => [ 'Menlo', 'DejaVu Sans Mono', 'Andale Mono', 'Courier New', 'monospace' ] },

      a   => {
                # font               => 'inherit',
                # color              => 'inherit',
               # 'background-color' => 'inherit',
               'text-decoration'  => 'inherit'
             },

     'a:hover' => { 'text-decoration' => 'underline' },

     'table'   => { 'font-size'   => '12px',
                    'font-family' => ['Arial', 'sans-serif'] } }
}

sub css_snippet_auxilary {
    { '.grey'     => { 'color'       => 'grey' },
      '.coord'    => { 'color'       => 'lightgrey', 'font-size'   => '10px' },
      '.ins'      => { 'background-color' => 'rgb(222,255,222)' },
      '.del'      => { 'background-color' => 'rgb(255,222,222)' },
      # '.snp'      => { 'background-color' => 'rgb(248,237,201)' },
      '.snp'      => { 'background-color' => '#99c2ff' },
      # '.snp'      => { 'background-color' => '#9999ff' },
      # '.snp'      => { 'color' => '#B45F04', 'font-weight' => 'bold' },
      # '.snp_row'  => { 'background-color' => '#ccedff' },
      '.snp_row'  => { 'background-color' => 'rgb(248,237,201)' },
      '.bold'     => { 'font-weight' => 'bold' },
      '.mono'     => { 'font-size'   => '12px',
                       'font-family' => [ 'Menlo', 'DejaVu Sans Mono', 'Andale Mono', 'Courier New', 'monospace' ] },
      '.collapse' => { 'color'       => 'lightgrey',
                       'font-weight' => 'bold' },
      '.textlink' => { 'background-color' => 'lightgrey',
                       'color'            => 'navy'} }
}

sub css_from_hash {
    my $hash = ref $_[0] eq 'HASH' ? $_[0] : \%_;
    
    my @lines;
    while (my ($k, $v) = each %$hash) {
        push @lines, "      $k {";
        while ($v && (my ($kk, $vv) = each %$v)) {
            my $prop = ($vv && ref $vv ne 'ARRAY') ? $vv : join(", ", map { / / ? "\"$_\"" : $_ } @$vv);
            push @lines, "        $kk: $prop;"
        }
        push @lines, "      }";
    }

    @lines = ("  <style type=\"text/css\">",
              "    <!--", @lines,
              "    -->",
              "  </style>");

    wantarray ? @lines : join("\n", @lines). "\n";
}


sub span_css {
    my ($text, $class) = @_;
    return $class ? "<span class=\"$class\">$text</span>" : $text;
}

sub mouseover_javascript {
    # return gjoalign2html::mouseover_JavaScript();
    return '<script language="JavaScript" type="text/javascript" src="http://bioseed.mcs.anl.gov/~fangfang/FIG/Html/css/FIG.js"></script>';
}

sub href {
    my ($txt, $url) = @_;
    return "<a href=\"$url\">$txt</a>" if $url;
    return $txt;
}

sub rast_href {
    my ($txt, $peg) = @_;
    my $url = "http://rast.nmpdr.org/seedviewer.cgi?page=Annotation&feature=$peg" if $peg;
    return "<a href=\"$url\">$txt</a>" if $url;
    return $txt;
}
