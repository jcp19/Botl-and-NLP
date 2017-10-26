#!/usr/bin/perl

use strict;
use Graph;
use utf8::all;

# process individual paragraphs
$/ = ''; 

my $window_size = 7;
# Convention: A regex nammed XX_Y captures Y groups. We can ommit Y if it equals 0.
my $NP = qr/\{\{ [^}]* \}\}/x;
my $NP_1 = qr/\{\{( [^}]*) \}\}/x;
my $spaces_and_points = qr/(?: \s|[!.?,;:])*/x;
my $words = qr/(?: \w|\d)+/x;
my $window = qr/(?: $spaces_and_points (?: $words| $NP)){0,$window_size}/x;
# Relations graph
my $graph = Graph::Undirected->new;

# takes a graph prints graphviz representation
# of it
sub print_graph {
  my $graph = shift;
  print "graph {\n";
  my @t = split(/,/, $graph->stringify());
  foreach(@t){
    s/(.*)=(.*)/"$1"--"$2"/g;
    print "$_\n";
  }
  print "}\n";
}

# Tests:
sub run_tests_regex {
  print "success 1\n" if "{{Joao}}" =~ /$NP/x;
  print "success 2: $1\n" if "{{Joao}}" =~ /$NP_1/x;
  print "success 3\n" if " . ," =~ /$spaces_and_points/x;
  print "success 4\n" if "ola" =~ /$words/x;
  print "success 5\n" if " ola" =~ /$window/x;
}

# simple example of 'relation' insertion in a graph
# and show the print function result
sub run_test_print_graph {
  $graph = $graph->add_edge("Joao", "Manel");
  $graph = $graph->add_edge("Rui", "Miguel");
  $graph = $graph->add_edge("Manel", "Rui");
  print_graph($graph);
}

# Main code:
while(<>){
  my $line = $_;
  my $matches;
  while($matches = $line =~ /$NP_1 (?= ($window))/gx){
    my $first_name = $1;
    my $this_window = $2;
    for my $name ($this_window =~ /$NP_1/g){
      $graph->add_edge($first_name, $name); 
    }
  }
}

print_graph($graph)
