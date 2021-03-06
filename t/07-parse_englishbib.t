#!/usr/bin/perl

use Test::More tests => 8;

use strict;
use IO::File;
use Text::BibLaTeX;


my $fh = IO::File->new("t/bibs/english.bib");

my $parser = new Text::BibLaTeX::Parser $fh;

my $count = 0;

my $entry = $parser->next;

is($entry->parse_ok, 0, "Ignore spurious @ before parenthesis");

$entry = $parser->next;

is($entry->parse_ok, 0, "Ignore spurious @ in email address");

$entry = $parser->next;

is(scalar $entry->author, 1, "# authors");
#@BOOK{Carey,
#   AUTHOR="G. V. Carey",
is($entry->field("title"), "Mind the Stop: A Brief Guide to Punctuation", "title");
is($entry->field("publisher"), "Penguin", "publisher");
is($entry->field("year"), 1958, "year");
$count++;

while ($entry = $parser->next) {
	$count++;
        if ($count == 8) {
            is( scalar $entry->author, 4, 'Last entry has 4 authors');
        }
}


is($count, 8, "number of entries");
