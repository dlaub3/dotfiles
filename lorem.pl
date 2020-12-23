#!/usr/bin/env perl

#
# credit https://unix.stackexchange.com/a/97163
#
use Text::Lorem;

my $text = Text::Lorem->new();
$paragraphs = $text->paragraphs(10);

print $paragraphs;
