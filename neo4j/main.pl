#!/usr/bin/perl

use strict;
use Graph;
use utf8::all;

# process individual paragraphs
$/ = ''; 

# Default values for variables
my $window_size = 7;
my $threshold = 0.3;
my $dbname = "test";

# Convention: A regex nammed XX_Y captures Y groups. We can ommit Y if it equals 0.
my $NP = qr/\{\{ [^}]* \}\}/x;
my $NP_1 = qr/\{\{( [^}]*) \}\}/x;
my $spaces_and_points = qr/(?: \s|[!.?,;:])*/x;
my $words = qr/(?: \w|\d)+/x;
my $window = qr/(?: $spaces_and_points (?: $words| $NP)){0,$window_size}/x;
# Relations graph
# my $graph = Graph::Undirected->new(countedged => 1, countvertexed => 1);
my $graph = Graph::Undirected->new();
my %nodes;
my %edges;

sub sort_values {
  my $v1 = shift;
  my $v2 = shift;
  return ($v1,$v2) if $v1 lt $v2; 
  return ($v2, $v1);
}

# takes a graph prints graphviz representation
# of it
sub print_graph {
  my $graph = shift;
  # print "MATCH (n) \nOPTIONAL MATCH (n)-[r]-() \nDELETE n,r\n";
  my @t = split(/,/, $graph->stringify());
  foreach(@t){
    my $catches = s/(.*)=(.*)/"$1"--"$2"/g;
    if ($catches == 0){
      s/(.*)/"$1"/;
      if($nodes{$1}){
         print "CREATE (:ProperName{ Name: \"$1\"})\n";
         $nodes{$1} = 0;
      }
    } else {
      if($nodes{$1}){
         print "CREATE (:ProperName{ Name: \"$1\"})\n";
         $nodes{$1} = 0;
      }
      if($nodes{$2}){
         print "CREATE (:ProperName{ Name: \"$2\"})\n";
         $nodes{$2} = 0;
      }
#      if($edges{
      print "WITH 1 as dummy 
MATCH (a:ProperName)
WITH a
MATCH (b:ProperName)
WITH b
WHERE a.Name = \"$1\" AND b.Name = \"$2\"
CREATE (a)-[:RELACIONA_SE_COM]->(b)\n";
    }
  }
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

sub stronger_relations {
    for my $key (keys %edges){
        my ($name1, $name2) = split ':', $key;
        $graph = $graph->delete_edge($name1, $name2) if ((($edges{$key} / $nodes{$name1}) < $threshold) && (($edges{$key} / $nodes{$name2}) < $threshold));
        # print("$key :::: $name1 :: $name2 :: $nodes{$name1} :: $nodes{$name2}\n");
    }
}

# Main code:
while(<>){
  my $line = $_;
  my $matches;
  while($matches = $line =~ /$NP_1 (?= ($window))/gx){
    my $first_name = $1;
    $graph->add_vertex($first_name);
    $nodes{$first_name}++;
    my $this_window = $2;
    for my $name ($this_window =~ /$NP_1/g){
      $graph->add_edge($first_name, $name); 
      my ($sort1, $sort2) = sort_values $first_name, $name;
      
#      if($first_name lt $name){
#        $sort1 = $first_name;
#        $sort2 = $name;
#      } else {
#        $sort1 = $name;
#        $sort2 = $first_name;
#      }
      $edges{"$sort1:$sort2"}++;
    }
  }
}

stronger_relations();

#print_graph($graph)

my ($a, $b) = sort_values "ola", "adeus";
print ("$a : $b\n");
