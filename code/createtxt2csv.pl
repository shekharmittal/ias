#!/usr/local/bin/perl
use strict;
use warnings;
#use Hash::Case::higher;

#my $TxtFile = "..\data\LokSabhaWinners1980.txt"; #@ARGV[0];
#my $CsvFile = "..\data\MPs.txt"; #@ARGV[1];

# step 1: open file
open (FILE, '../data/constituencies.csv');
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
open (FILE, '../data/LokSabhaWinners1980.txt');

#Now start matching the constituencies to the hash and writing it into a text fil
open (ERRORFILE, '>../data/errorlog.txt');
open (CSVFILE, '>../data/MPs.txt');
 
while (<FILE>){
    chomp();
#    print " the string is $_\n";
    if ($_ =~/^\D/){
#        print "ERROR: in place 1 \n";
	print ERRORFILE "$_\n";
	next;
    }
    elsif ($_ =~/^\d+\..*\d/){
#        print "ERROR: in place 2 \n";
        print ERRORFILE "$_\n";
    }elsif($_ =~/^\d+\./){
#        $_=~m/(\(.*\))%/;
        $_=~/^\d+\.\s([\w]+)(.*)\s([\w\(\)]*)$/;
        print "NO ERROR: in place 3, key value 1 is $1 \n";
        my $key1 = $1;
        if (exists $hash{$key1}){
#            print "NO ERROR: in place 5 \n";
            my $value = shift($hash{$key1});
        #   my $value = $hash{"$key1"};
        #   if($value){print "$key1 => $value\n";}
            if ($value){
#                print "In the first hash function \n ";
                print CSVFILE "$1,$value,$2,$3\n";
                next;
            }
	}
        $_=~/^\d+\.\s([\w]+\s[\(\)\w]*)(.*)\s([\w\(\)]*)$/;
#        print "NO ERROR: in place 6, key value is $1 \n";
#        print "$1\n";
        my $key2 = $1;
        if (exists $hash{$key2}){
#            print "NO ERROR: in place 7 \n";
            my $value1 = shift($hash{$key2});
            if ($value1){ 
#                print "In the second hash function \n ";
                print CSVFILE "$1,$value1,$2,$3\n";
                next;
        	}
	}
#        print "ERROR: in place 4 \n";
        print ERRORFILE "$_\n";
    }
}
close (ERRORFILE); 
close (CSVFILE); 
