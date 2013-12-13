
use strict;
use warnings;

use Module::Build 0.3601;
use lib qw{inc}; use Alien::o2dll::ModuleBuild;

my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Make dynamic link library",
  "dist_author" => [
    "Graham Ollis <plicease\@cpan.org>"
  ],
  "dist_name" => "Alien-o2dll",
  "dist_version" => "0.02",
  "license" => "perl",
  "module_name" => "Alien::o2dll",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Alien::MSYS" => 0,
    "File::ShareDir" => 0,
    "base" => 0,
    "perl" => "5.008"
  },
  "script_files" => [
    "bin/po2dll"
  ],
  "share_dir" => {
    "dist" => "share"
  },
  "test_requires" => {
    "Test::More" => 0
  }
);


my %fallback_build_requires = (
  "Module::Build" => "0.3601",
  "Test::More" => 0
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Alien::o2dll::ModuleBuild->new(%module_build_args);

$build->create_build_script;
