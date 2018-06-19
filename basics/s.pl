#!/bin/perl
#ident "@(#) Symbolic references.. Atre 08 Feb 2008"

$name = "foo";


#---------------------------------
# Symbolic reference to a scalar..
#---------------------------------
$$name = 1; # Should set $foo to 1..
print "foo [$foo]\n";

${ $name } = 2; # Sets $foo to 2..
print "foo [$foo]\n";

$ { $name x 2 } = 3; # Sets $foofoo to 3..
print "foofoo [$foofoo]\n";

#---------------------------------
# Symbolic reference to an array..
#---------------------------------
@$name = ( 1 .. 3 );
print "Array foo contains [", join ( ' ', @foo ), "]\n";

#--------------------------------
# Symbolic reference to a hash..
#--------------------------------
%$name = ( 'one' => 1, 'two' => 2, 'three' => 3 );
print "Keys for hash foo are [", join ( ' ', keys %foo ), "]\n";
