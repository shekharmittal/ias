#!/usr/local/bin/perl
use strict;
use CAM::PDF;
my $pdf = CAM::PDF->new('test.pdf') or die "Can't open test.pdf: $!";;
print $pdf->numPages()."\n";


#while (<my $pdf>) {
#chomp($_);
#$_ =~ m/^(\d+).\s+((?:[\w\(\)\.]+\s+)*)([\w\(\)]+\s+)$/;
#print "$_\n";
#print "$1:$2:$3\n";
#}
for my $i (73) {
    my $pdf1 =  $pdf->getPageText($i);
    open my $overwrite, '>', 'pdf.txt' or die "error trying to overwrite: $!";
    # Wave goodbye to the original contents.
    say $overwrite $pdf1;

    print $pdf1;
    chomp($pdf1);
    while (<$pdf1>){
        $pdf1 =~ m/^(\d+).\s+((?:[\w\(\)\.]+\s+)*)([\w\(\)]+\s+)$/;
        #    print "$pdf1 \n";
        print "$1:$2:$3\n";
    }
}
