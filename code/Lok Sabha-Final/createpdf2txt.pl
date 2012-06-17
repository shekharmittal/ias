#!/usr/local/bin/perl
# this is a code that works. Just need to change the page numbers and file names # and it should be good to go. Be very careful while making any modifications 
use strict;
use CAM::PDF;

my $FromPage = 1 ;#@ARGV[2];
my $ToPage = 18 ;#@ARGV[3];

my $pdf = CAM::PDF->new("../data/ls15.pdf") or die "Can't open File: $!";
#open my $FILE, '>', '$TxtFile' or die "error trying to append: $!";
open (FILE, '>../data/loksabhawinners2009_2.txt');
for my $i ($FromPage .. $ToPage) {
    my $pdf1 =  $pdf->getPageText($i);
    print FILE "$pdf1";
}
close (FILE); 


