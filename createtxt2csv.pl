#!/usr/local/bin/perl
use strict;
use warnings;

my $TxtFile = "LokSabhaWinners1980.txt"; #@ARGV[0];
my $CsvFile = "MPs.txt"; #@ARGV[1];

# step 1: open file
open (FILE, 'constituencies.csv');
#Fill everything into a hash
my %hash;
while (<FILE>){
    chomp;
     my ($const, $state) = split(":");
     my $value = $hash{"$const"};
     if ($value){
         print "ERROR: Hash already exists:$const:$state:$hash{$const} \n";      }
     #$hash{$const} .= exists $hash{$const} ? "$state" : $state;
    $hash{$const} = [] unless exists $hash{$const};
    push($hash{$const}, $state);
}
close (FILE);
#my $i=0;
#while ( my ($key, $value) = each(%hash) ) {
#        print "$key=>$value\n";
#        $i++;
#    }
#print "The number of keys are $i\n";
open (FILE, 'LokSabhaWinners1980.txt');

#Now start matching the constituencies to the hash and writing it into a text fil
open (ERRORFILE, '>errorlog.txt');
open (CSVFILE, '>MPs.txt');
 
while (<FILE>){
    chomp();
    if ($_ =~/^\D/){
	print ERRORFILE "$_\n";
	next;
    }
    elsif ($_ =~/^\d+\..*\d/){
           print ERRORFILE "$_\n";
    }elsif($_ =~/^\d+\./){
        $_=~/^\d+\.\s([\w]+)(.*)\s([\w\(\)]*)$/;
#       print "$1\n";
        my $key1 = $1;
        if (exists $hash{$key1}){
            my $value = shift($hash{$key1});
        #   my $value = $hash{"$key1"};
        #   if($value){print "$key1 => $value\n";}
            if ($value){
                print "In the first hash function \n ";
                print CSVFILE "$1,$2,$3\n";
                next;
            }
	}
        $_=~/^\d+\.\s([\w]+\s[STC\(\)]*)(.*)\s([\w\(\)]*)$/;
#        print "$1\n";
        my $key2 = $1;
        if (exists $hash{$key2}){
            my $value1 = shift($hash{$key2});
            if ($value1){ 
                print "In the second hash function \n ";
                print CSVFILE "$1,$2,$3\n";
                next;
        	}
	}
        print ERRORFILE "$_\n";
    }
}
close (ERRORFILE); 
close (CSVFILE); 
