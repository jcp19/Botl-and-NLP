#!/usr/bin/perl

use strict;
use warnings;
use utf8::all;

my $file = 'Englishdictionary.txt';
open my $fh, '<', $file
  or die "Can't open file : $!";
my $flag = 0;
my $input;
while(<$fh>) {
    $input = $_;
    if ($flag == 0){
        if($input =~ /^[A-Z]+\n/g){
            chomp $input;
            $flag = 1;
            print "RESPOND TO [Dd]efinition of /$input/i[?]? WITH \"";
        }
    }
    elsif ($flag == 1) {
        if($input =~ /^Defn/){
            
            chomp $input;
            print "$input ";
            $flag = 2;
        }
    }
    else {
        if ($input =~ /^\n/){
            $flag = 0;
            print "\"\n";
        }
        else { 
            chomp $input;
            print "$input ";
        }
    }
}
#TO DO
#Processar paragrafo a paragrafo
#Sempre que encontrar /[A-Z\-]{2,}\n/ -> (word to define)
#Apanha tudo após /Defn:/ até linha em branco -> (definition)
#Resultando na regra RESPOND TO "Definition of /word/i" WITH definition 