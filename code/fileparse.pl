#!/usr/bin/perl
#This is the working code for how to parse a file line by line and it works! dont play with this one. 
 open (FILE, 'Andhra.txt');
 while (<FILE>) {
 chomp;
 ($const, $state) = split(":");
 print "Name: $const\n";
 print "State: $state\n";
 }
 close (FILE);
 exit;
