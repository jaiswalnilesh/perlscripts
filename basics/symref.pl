#!/usr/bin/perl -w
#ident "@(#) Demonstrate usage of symbolic refs.. Atre 08 Feb 2008"

#use strict;

my $x = 1;
my $var = "x";

#---------------------------------------
# Symbolic reference to another scalar..
#---------------------------------------
print "x [$x] var [$var]. Assiging \$\$var 30\n";
$$var = 30;
print "Var [$var] x [$x]\n";

#---------------------------------
# Symbolic reference to an array..
#---------------------------------
my $foo = "bar";

print "Assigning \@\$foo 1 to 10\n";
@$foo = ( 1 .. 10 );
print "Array bar has [", join ( ' ', @bar ), "]\n";

#-------------------------------
# Symbolic reference to a hash..
#--------------------------------
my $doo = "hash";
my $key = undef;
print "Doo has [$doo]\n";

print "Assigning \%\$doo 1 to 10\n";
%$doo = map { $_ => 1 } ( 1 .. 10 );

print "Printing the contents of Hash hash: \n";
foreach $key ( sort { $a <=> $b } keys %hash ) {
  print "key [$key] value [", $hash { $key }, "]\n";
}
