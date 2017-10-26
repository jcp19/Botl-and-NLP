#!/usr/bin/perl

use strict;
use Graph;
use utf8::all;

# processar paragrafo a paragrafo
$/ = ''; 

my $graph = Graph::Undirected->new;

#my $PM = qr{\b[A-Z][\w-]*\w};
#my $de = qr{d[aoe]s?};
#my $s = qr{[\n ]};
#my $np = qr{$PM (?: $s $PM | $s $de $s $PM )*}x;
#
my $window_size = 7;
# my $window = qr{($np) (?: $s+ (?: \w+|($np))**0..$window_size)};
# my $window = qr{($np) (?: $s+ (\w+))*};

#while(<>){
#  while(/($np) (?=(?: $s+ (\w+))*)/xg){
#  # falta por ?=
#  s/($np)/normaliza("$1")/ge;
#  while(/($np) (?: $s+ (?: [\w-]+ | ($np))) ** {0..$window_size} /xg){
#      print("\$1:  $1 and \$2: $2 \n");
#  } 
#}

# Convention: A regex nammed XX_Y captures Y groups. We can ommit Y if it equals 0.
my $NP = qr/\{\{ [^}]* \}\}/x;
my $NP_1 = qr/\{\{( [^}]*) \}\}/x;
my $spaces_and_points = qr/(?: \s|[!.?,;:])*/;
my $words = qr/(?: \w|\d)+/x;
my $window = qr/(?: $spaces_and_points (?: $words| $NP)){0,$window_size}/x;

# Tests:
print "success 1\n" if "{{Joao}}" =~ /$NP/x;
print "success 2: $1\n" if "{{Joao}}" =~ /$NP_1/x;
print "success 3\n" if " . ," =~ /$spaces_and_points/x;
print "success 4\n" if "ola" =~ /$words/x;
print "success 5\n" if " ola" =~ /$window/x;


while(<>){
#  my $line = $_;
#  # deteta os nomes do ficheiro anotado
#  while($line =~ /\{\{( [^}]*)  \}\}  (?=((?:.|\n)*)) /gx){
#    my $name = $1;
#    my $tail = $2;
#    # este devia dar!
#    # tem de ser assim, no ciclo, senao imprime sempre o ultimo resultado
#    for my $i (1..$window_size){
#       $tail =~ /^(?: \s*[!.?,;:]*\s* (?:\w+|\{\{( [^}]*)  \}\})){1,$i}/gx;
#       print "::: $name :: $tail :: $1 :: $2 \n" 
#    };
#
  my $line = $_;
  my $matches;
#  while($line =~ /\{\{( [^}]*)  \}\}  (?=((?:.|\n)*)) /gx){
  while($matches = $line =~ /$NP_1 ($window)/gx){
    print ":::: $1 :: $matches :: $2 \n";
  }





#    for my $cena (@cenas){
#      print $cena; 
#    }
 
    
    #print "::: $1 :: $line :: $2 $3\n";
 
#    while($c < 7){
      
#    }
#    my @x =  /(?=(?: $s+ (?: [\w-]+ | (\{\{ [^}]*  \}\}))){1,7})/gx;
#    my $a = @x;
#    print "$a\n";
#    #my @x = /(?=(?: $s+ (?: [\w-]+ | ($np)) ){1,7})/gx;
#    my @x = /(?=(?: $s+ (?: [\w-]+ | \{\{.*\}\}) ){1,7})/gx;
#    my $y = join(", ", @x);
#    print("$y\n");
#  }
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
