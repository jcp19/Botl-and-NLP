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

package NLP::PN;

use 5.024001;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use NLP::PN ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';


# Preloaded methods go here.

1;
__END__
=head1 NAME

NLP::PN - Perl extension for blah blah blah

=head1 SYNOPSIS

=head1 DESCRIPTION

=head2 EXPORT

=head1 HISTORY

=over 8

=item 0.01

=back

=head1 SEE ALSO

=head1 AUTHOR

João, E<lt>joaopereira.19@gmail.com<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2017 by João

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.24.1 or,
at your option, any later version of Perl 5 you may have available.
=cut
