#!/usr/local/bin/perl
use strict;
use CAM::PDF;
#use PDF;

my $pdf = CAM::PDF->new("test.pdf") or die "Can't open PC.pdf: $!";;
my $PageNum = $pdf->numPages();
print $PageNum."\n";
open my $append, '>', 'politicians.txt' or die "error trying to append: $!";
for my $i (73 .. 85) {
    my $pdf1 =  $pdf->getPageText($i);
    # Wave goodbye to the original contents.
    say $append $pdf1;
}
