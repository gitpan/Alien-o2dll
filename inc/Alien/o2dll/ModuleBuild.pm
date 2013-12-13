package Alien::o2dll::ModuleBuild;

use strict;
use warnings;
use base qw( Module::Build );

sub new
{
  my $class = shift;
  my %args = @_;
  
  die "operating system no supported" unless $^O eq 'MSWin32' || $^O eq 'cygwin';
  
  $class->SUPER::new(%args);
}

1;
