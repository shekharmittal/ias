#!/usr/local/bin/perl
use strict;
use CAM::PDF;
#use PDF;
my $pdf = CAM::PDF->new("PC.pdf") or die "Can't open PC.pdf: $!";;
my $PageNum = $pdf->numPages();
for my $i (1 .. $PageNum) {
    my $pdf1 =  $pdf->getPageText($i);
    open my $append, '>>', 'constituencies.txt' or die "error trying to append: $!";
    # Wave goodbye to the original contents.
    say $append $pdf1;
}
