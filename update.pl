#!/usr/bin/perl -w

use strict;

open FILE1, "<Vehicles";
open FILE2, ">>Vehicles4";
my $n = 0;
my $line;
my $started = 0;
while(<FILE1>){
   if(/><\//){
      my $word = <STDIN>;
      chomp $word;
      last if $word eq "exit";
      s/><\//>$word<\//;
      $started = 1;
   }
   if($started == 1){
      print;
      print "\n";
      print FILE2 $_;
   }
}
print "EOF";
