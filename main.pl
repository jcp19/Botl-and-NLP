#!/usr/bin/perl

use strict;
use Graph;
use utf8::all;

# processar paragrafo a paragrafo
$/ = ''; 

my $PM = qr{\b[A-Z][\w-]*\w};
my $de = qr{d[aoe]s?};
my $s = qr{[\n ]};
my $np = qr{$PM (?: $s $PM | $s $de $s $PM )*}x;

my $window_size = 7;
# my $window = qr{($np) (?: $s+ (?: \w+|($np))**0..$window_size)};
my $window = qr{($np) (?: $s+ (\w+))*};

while(<>){
  while(/$window/){
      print("\$0 é $0 e \$1 é $1\n");
  } 
}


