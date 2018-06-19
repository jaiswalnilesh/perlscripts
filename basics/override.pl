#!/usr/bin/perl -w

use strict;

use subs ( chdir );

sub chdir {
  print "just printing chdir [", @_, "]\n";
}

&chdir ( "atre is boring" );
