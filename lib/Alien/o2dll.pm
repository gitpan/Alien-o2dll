package Alien::o2dll;

use strict;
use warnings;
use File::ShareDir qw( dist_dir );
use Alien::MSYS;
use base qw( Exporter );
use File::Spec;

our @EXPORT_OK = qw( o2dll o2dll_path );

# ABSTRACT: Make dynamic link library
our $VERSION = '0.03'; # VERSION


sub o2dll
{
  my @args = @_;
  msys {
    system('sh', File::Spec->catfile(dist_dir('Alien-o2dll'), qw( bin o2dll.sh )), @args);
    if($? == -1) {
      die "failed to execute: $!";
    } elsif($? & 127) {
      die sprintf("child died with signal %d", $? & 127);
    } elsif($?) {
      die sprintf("child exited with value %d", $? >> 8);
    }
  };
}


sub o2dll_path
{
  File::Spec->catfile(dist_dir('Alien-o2dll'), qw( bin ));
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Alien::o2dll - Make dynamic link library

=head1 VERSION

version 0.03

=head1 SYNOPSIS

From perl:

 use Alien::o2dll qw( o2dll );
 
 o2dll( -o => 'foo.dll', -l => 'otherlib', 'foo.o', '-version-info' => '0:0:0' );

From command line:

 C:\> po2dll -o foo.dll -l otherlib foo.o -version-info 0:0:0

=head1 DESCRIPTION

o2dll is a shell script that is used in some build scripts used to create DLL files
on Windows.  Installing this module provides a perl interface to that command, as 
well as a command line interface C<po2dll> (it has a p prefix so as not to interfere
with o2dll if you have installed it yourself).

=head1 FUNCTIONS

These functions are exported to the callers namespace only by request.

=head2 o2dll

 o2dll( -o => 'foo.dll', -l => 'otherlib', 'foo.o', '-version-info' => '0:0:0' );

Run o2dll with the given arguments.  It will die if there is a failure.

=head2 o2dll_path

 my $dir = o2dll_path;

Returns the path to the o2dll executable shell script.

=head1 AUTHOR

Graham Ollis <plicease@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
