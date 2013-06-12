#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use FindBin;
use Path::Tiny;

use lib path($FindBin::Bin)->parent->child('lib')->stringify;
use twteam;

my $root = path($FindBin::Bin)->parent;
my $src = $root->child('data');
my $out = $root->child('out');

for my $file ( $src->children ){ 
    $out->child($file->basename)->spew( twteam->from_file( $file )->to_s );
}

