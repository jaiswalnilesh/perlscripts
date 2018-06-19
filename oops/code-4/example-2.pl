#!/usr/bin/perl

use Animal;
use Mouse;

{
    my $mouse = Mouse->mynew("Stuart Little", "white");
    $mouse=Mouse->mynew("Stuart Little2", "white");
    print "reassignment done\n";
    sleep(5);
}
print "out of block\n";
