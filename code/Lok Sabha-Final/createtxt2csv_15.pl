#!/usr/local/bin/perl
# this is a code that works. Just need to change the page numbers and file names # and it should be good to go. Be very careful while making any modifications 
# This code is the modified regex for the new format of data for 2009 elections. I don't know why the election commission does this to us!
use strict;
use warnings;

# step 1: Create a hash of arrays for the constituencies
open (FILE, '../data/constituencies_15_modified.csv');
#Fill everything into a hash
my %hash;
while (<FILE>){
    chomp;
     my ($const, $state) = split(",");
     my $value = $hash{"$const"};
     if ($value){
         print "ERROR: Hash already exists:$const:$state:$hash{$const} \n";           }
    $hash{$const} = [] unless exists $hash{$const};
    push($hash{$const}, $state);
}
close (FILE);
open (FILE, '../data/loksabhawinners2009_2.txt');
#Now start matching the constituencies to the hash and writing it into a text fil
open (ERRORFILE, '>../data/errorlog_15.txt');
open (CSVFILE, '>../data/MPs_15.txt');
while (<FILE>){
    chomp($_);
    if ($_ =~/\D$/){
	print ERRORFILE "$_\n";
	next;
    }elsif($_ =~/\d+$/){
        $_=~/^([\w\-]+)\s(.*)\s([\w\)\(]*)\s\d+$/;
        my $key1 = $1;
        if (exists $hash{$key1}){
            my $value = shift($hash{$key1});
            if ($value){
                print CSVFILE "$1,$value,$2,$3\n";
                next;
            }
	}
        $_=~/([\w\-]+\s[\w\-]*)(.*)\s([\w\(\)]*)\s\d+$/;
        my $key2 = $1;
        if (exists $hash{$key2}){
            my $value1 = shift($hash{$key2});
            if ($value1){ 
                print CSVFILE "$1,$value1,$2,$3\n";
                next;
        	}
	}
        print ERRORFILE "$_\n";
    }
}
close (ERRORFILE); 
close (CSVFILE); 
