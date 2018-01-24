#!/usr/bin/perl

use strict;
use utf8::all;
$/ = ''; # processar paragrafo a paragrafo

my %names;
my @names_arr;

my $PM = qr{\b[A-Z][\w-]*\w};
my $de = qr{d[aoe]s?};
my $s = qr{[\n ]};
my $np = qr{$PM (?: $s $PM | $s $de $s $PM )*}x;

while (<>) {
	s/(^|[.!?][ \n]|^-- )/$1_/g;
	s/($np)/normaliza("{{$1}}")/ge;
	s/_//g;

	print $_;
}

sub normaliza { my $p = shift;
 if($p=~s/\s+/ /g){
   return "\n$p";
 } else {return $p;} 
}
