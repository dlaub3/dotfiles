#!/usr/bin/env perl
use 5.32.0;
use Data::Dumper;
use Text::Lorem;

my $count = $ARGV[0] || 10;
my $text = Text::Lorem->new();
my @words = split(/ /, $text->paragraphs($count));

my $lorem = '';
while($count--) {
  $lorem = $lorem . ' ' . @words[$count];
}

$lorem =~ s/\n//g;

say $lorem;
