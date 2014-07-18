#! /usr/bin/env perl

use strict;
use Carp;
use Cwd 'abs_path';
use Data::Dumper;

my $usage = "Usage: $0 SRR_ID.faa ref.faa\n\n";

my $qry = shift @ARGV;
my $ref = shift @ARGV;
my $pre = clean_name($qry);

$qry && $ref or die $usage;

my $qry_name = file_name($qry);
my $ref_name = file_name($ref);

$qry = abs_path($qry);
$ref = abs_path($ref);

run("find_bidir_best_hits -f -F -l $qry $ref -a 8 > $pre.bbhs");

my @lines = parse_bbh_log($ref, $qry);
print join("\n", @lines) . "\n";


sub parse_bbh_log {
    my ($ref, $qry) = @_;
    my $qry_gff = find_gff_file($qry);
    my $ref_gff = find_gff_file($ref);
    my $qry_hash = parse_gff($qry_gff);
    my $ref_hash = parse_gff($ref_gff);
    
    my $log1 = "$ref_name\_vs_$qry_name.log";
    my $log2 = "$qry_name\_vs_$ref_name.log";
    my @diff1 = extract_diff_from_bbh_log($log1);
    my @diff2 = extract_diff_from_bbh_log($log2);
    my @diffs = @diff1;
    for (@diff2) {
        my ($qid, $qlen, $type, $sid, $slen, $fract_id, $fract_pos, $q_cover, $s_cover) = @$_;
        next if $type eq '<->';
        $type = '<- ' if $type eq ' ->';
        push @diffs, [ $sid, $slen, $type, $qid, $qlen, $fract_id, $fract_pos, $s_cover, $q_cover ];
    }
    
    my @diff_objs;
    for (@diffs) {
        my ($qid, $qlen, $type, $sid, $slen, $fract_id, $fract_pos, $q_cover, $s_cover) = @$_;
        my $hash = { ref_id       => $qid,
                     ref_len      => $qlen,
                     type         => $type,
                     qry_id       => $sid,
                     qry_len      => $slen,
                     fract_id     => $fract_id,
                     fract_pos    => $fract_pos,
                     ref_cov      => $q_cover,
                     qry_cov      => $s_cover,
                     ref_contig   => $ref_hash->{$qid}->{seqname},
                     ref_beg      => $ref_hash->{$qid}->{start},
                     ref_end      => $ref_hash->{$qid}->{end},
                     ref_function => $ref_hash->{$qid}->{annotation},
                     qry_contig   => $qry_hash->{$sid}->{seqname},
                     qry_beg      => $qry_hash->{$sid}->{start},
                     qry_end      => $qry_hash->{$sid}->{end},
                     qry_function => $qry_hash->{$sid}->{annotation},
                   };

        push @diff_objs, $hash;
    }
    return diffs_to_lines(\@diff_objs, 'show_header');
}

sub diffs_to_lines {
    my ($diffs, $show_header, $show_ref_contig) = @_;
    my @lines;
    my @cols;
    if ($show_ref_contig) {
        @cols = qw(ref_contig ref_beg ref_end ref_id ref_len type qry_id qry_len fract_id fract_pos ref_cov qry_cov qry_contig qry_beg qry_end ref_function qry_function);
    } else {
        @cols = qw(ref_beg ref_end ref_id ref_len type qry_id qry_len fract_id fract_pos ref_cov qry_cov qry_contig qry_beg qry_end ref_function qry_function);
    }
    if ($show_header) { push @lines, join("\t", @cols) }
    my @diffs = sort_diff_objs($diffs);
    for (@diffs) {
        my $line = diff_hash_to_line($_, \@cols);
         push @lines, $line;
    }
    wantarray ? @lines : \@lines;
}

sub diff_hash_to_line {
    my ($hash, $cols) = @_;
    $cols ||= [qw(ref_id ref_len type qry_id qry_len fract_id fract_pos ref_cov qry_cov ref_contig ref_beg ref_end qry_contig qry_beg qry_end ref_function qry_function)];
    my $line = join("\t", map { $hash->{$_} } @$cols);
    return $line;
}

sub sort_diff_objs {
    my ($objs) = @_;
    my @diffs = sort { my ($a_rid) = $a->{ref_id} =~ /CDS\.(\d+)/;
                       my ($b_rid) = $b->{ref_id} =~ /CDS\.(\d+)/;
                       my ($a_qid) = $a->{qry_id} =~ /CDS\.(\d+)/;
                       my ($b_qid) = $b->{qry_id} =~ /CDS\.(\d+)/;
                       $a->{ref_beg} <=> $b->{ref_beg} ||
                       $a->{ref_end} <=> $b->{ref_end} ||
                       $a_rid <=> $b_rid ||
                       $a_qid <=> $b_qid ||
                       $a->{ref_id} cmp $b->{ref_id} ||
                       $a->{qry_id} cmp $b->{qry_id}
                   } @$objs;
    wantarray ? @diffs : \@diffs;
}

sub extract_diff_from_bbh_log {
    my ($log) = @_;
    my @diffs;
    my @lines = `cat $log`;
    for (@lines) {
        chomp;
        my @fields = split /\t/;
        # qid: contig ids in ref
        # sid: contig ids in qry
        my ($qid, $qlen, $type, $sid, $slen, $fract_id, $fract_pos, $q_cover, $s_cover) = @fields;
        next unless $type ne '<->' || $fract_id < 1 || $q_cover < 0.9 || $s_cover < 0.9;
        next if $fract_id >= 0.98 && $q_cover >= 0.98 && $s_cover >= 0.98;
        push @diffs, \@fields;
    }
    wantarray ? @diffs : \@diffs;
}

sub parse_gff {
    my ($file) = @_;
    my @lines = `grep -v "^#" $file`;
    my %hash;
    for (@lines) {
        chomp;
        my ($contig, $source, $type, $beg, $end, $score, $strand, $frame, $attribute) = split/\t/;
        # my ($id, $name) = $attribute =~ /ID=(.*);Name=(.*)/;
        my %attr;
        for (split(/;/, $attribute)) {
            my ($k, $v) = split/=/;
            $attr{$k} = $v;
        }
        my $id = $attr{ID};
        my $func = $attr{Name};
        $hash{$id} = { seqname    => $contig,
                       source     => $source,
                       feature    => $type,
                       start      => $beg,
                       end        => $end,
                       score      => $score,
                       strand     => $strand,
                       frame      => $frame, 
                       attribute  => $attribute,
                       annotation => $func };
    }
    wantarray ? %hash : \%hash;
}

sub find_gff_file {
    my ($name) = @_;
    $name =~ s/faa/gff/;
    return $name if -s $name;
}

sub file_name {
    my ($name) = @_;
    $name =~ s/.*\///;
    $name;
}

sub clean_name {
    my ($name) = @_;
    $name =~ s/.*\///;
    $name =~ s/\.(fasta|faa|fna|fa)//;
    $name =~ s/\.contigs//;
    $name;
}

sub run { system(@_) == 0 or confess("FAILED: ". join(" ", @_)); }
