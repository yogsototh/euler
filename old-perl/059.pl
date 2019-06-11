#!/usr/bin/perl
# Source projecteuler.net forum
use List::Util qw/ sum /;
open(FILE,"cipher1.txt") or die ("Unable to open file");
$cypher = join '', map { chr($_) } split /,/,<FILE>;
$l = length $cypher;

for my $key ('aaa' .. 'zzz') {
    $text = $cypher ^ ( $key x int ($l/3)
                        . substr($key,0,$l%3)
                      );
    if ( $text =~ / and /i or $text =~ / the /i ) {
        print "$key: $text$/";
        last;
    }
}

print "Ascii total: ", sum map { ord($_) } split //, $text;
print "\n";
