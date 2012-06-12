#!/usr/local/bin/perl
use strict;
use CAM::PDF;

my $PdfFile = "test.pdf"; #@ARGV[0];
my $TxtFile = "parties.txt"; #@ARGV[1];
my $FromPage = 4 ;#@ARGV[2];
my $ToPage = 4 ;#@ARGV[3];

my $pdf = CAM::PDF->new("$PdfFile") or die "Can't open $PdfFile: $!";x
open my $append, '>', '$TxtFile' or die "error trying to append: $!";
for my $i ($FromPage .. $ToPage) {
    my $pdf1 =  $pdf->getPageText($i);
    say $append $pdf1;
}
