#!/usr/bin/perl

use strict;
use Graph;
use utf8::all;

# processar paragrafo a paragrafo
$/ = ''; 

my $graph = Graph::Undirected->new;

my $PM = qr{\b[A-Z][\w-]*\w};
my $de = qr{d[aoe]s?};
my $s = qr{[\n ]};
my $np = qr{$PM (?: $s $PM | $s $de $s $PM )*}x;

my $window_size = 7;
# my $window = qr{($np) (?: $s+ (?: \w+|($np))**0..$window_size)};
my $window = qr{($np) (?: $s+ (\w+))*};

#while(<>){
#  while(/($np) (?=(?: $s+ (\w+))*)/xg){
#  # falta por ?=
#  s/($np)/normaliza("$1")/ge;
#  while(/($np) (?: $s+ (?: [\w-]+ | ($np))) ** {0..$window_size} /xg){
#      print("\$1:  $1 and \$2: $2 \n");
#  } 
#}

while(<>){
  my $line = $_;
  # deteta os nomes do ficheiro anotado
  while($line =~ /\{\{( [^}]*)  \}\}  (?=((?:.|\n)*)) /gx){
    my $name = $1;
    my $tail = $2;
    # este devia dar!
    my @cenas = $tail =~ /^(?: (\s*[!.?,;:]*\s*) (?:([\w]+)|\{\{( [^}]*)  \}\})){1,7}/gx;
#    for my $cena (@cenas){
#      print $cena; 
#    }
    my $shit = @cenas;
    print "::: $name :: $shit ::$tail :: $1\n" 
 
    
    #print "::: $1 :: $line :: $2 $3\n";
    my $c;
 
#    while($c < 7){
      
#    }
#    my @x =  /(?=(?: $s+ (?: [\w-]+ | (\{\{ [^}]*  \}\}))){1,7})/gx;
#    my $a = @x;
#    print "$a\n";
#    #my @x = /(?=(?: $s+ (?: [\w-]+ | ($np)) ){1,7})/gx;
#    my @x = /(?=(?: $s+ (?: [\w-]+ | \{\{.*\}\}) ){1,7})/gx;
#    my $y = join(", ", @x);
#    print("$y\n");
  }
}

# simple example of 'relation' insertion in a graph
# and show the print function result
$graph = $graph->add_edge("Joao", "Manel");
$graph = $graph->add_edge("Rui", "Miguel");
$graph = $graph->add_edge("Manel", "Rui");
print_graph($graph);

sub normaliza { my $p = shift;
	if($p=~s/\s+/ /g){
		return "\n$p";
	} else { return $p; }
}

# takes a graph prints graphviz representation
# of it
sub print_graph {
	my $graph = shift;
	open FILE, ">graph.gv";
	print FILE "graph {\n";
	my @t = split(/,/, $graph->stringify());
	foreach(@t){
		s/(\w)=(\w)/$1--$2/g;
		print FILE "$_\n";
	}
	print FILE "}";
	close FILE;
}
