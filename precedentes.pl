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
#my $wleft = qr/(?: (?: \b\w+\b) $spaces_and_points){0,2}/x;
my $wleft = qr/(?: (?: \w+) (?: \s|,)*){0,2}/x;
my @forget =('o','a','os','as','de','do','da','dos','das','para','e','em','sua','ou','que');

# Relations graph
# my $graph = Graph::Undirected->new(countedged => 1, countvertexed => 1);
my $graph = Graph::Undirected->new();
my %nodes;
my %edges;
my %names;

sub print_possible_adjs {
  for my $key (keys %names){
    print "$key:\n";
	for my $madj (keys %{%names{$key}}){
      print "\t$madj: $names{$key}{$madj}\n";
	}
  }
}

# Main code:
while(<>){
  my $line = $_;
  my $matches;
  my $sort1;
  my $sort2;
  while($matches = $line =~ /(?:($wleft)) $NP_1 (?= ($window))/gx){
    my $first_name = $2;
    $graph->add_vertex($first_name);
    $nodes{$first_name}++;
	for my $maybe_adj ($1 =~ /\b\w+\b/gx){
	  $names{$first_name}{$maybe_adj}++ if ! ($maybe_adj ~~ @forget);
	}

    my $this_window = $3;
    for my $name ($this_window =~ /$NP_1/g){
      $graph->add_edge($first_name, $name); 
      if($first_name lt $name){
        $sort1 = $first_name;
        $sort2 = $name;
      } else {
        $sort1 = $name;
        $sort2 = $first_name;
      }
      $edges{"$sort1:$sort2"}++;
    }
  }
}

print_possible_adjs();
