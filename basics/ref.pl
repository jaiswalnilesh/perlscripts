#!/usr/bin/perl -w
#ident "@(#) Using references.. Atre 26 Dec 2007"

use strict;

#--------------------------------
# Making references to a scalar..
#--------------------------------
my $iCnt = 23;
my $riCnt = \$iCnt;

print "Cnt [$iCnt] Ref-Cnt [$riCnt] Ref-Cnt value [$$riCnt]\n";

#-------------------------------
# Making reference to an array..
#-------------------------------
my @liList = ( 1 .. 10 );
my $rliList = \@liList;
print "Ref-List [$rliList] Array [", join ( ' ', @$rliList ), "]\n";
print "Same as [", join ( ' ', @{ $rliList }  ), "]\n";

#-----------------------------
# Making references using []..
#-----------------------------
my $rliData = [ 10 .. 20 ]; # Same as [ 10 .. 20 ]
print "Ref-Data [$rliData] Array [", join ( ' ', @$rliData ), "]\n";
print "Same as [", join ( ' ', @{ $rliData }  ), "]\n";

#---------------------------------
# Reference to an anonymous hash..
#---------------------------------
my $rhlPairs = { 'Ram'     => 'Lakhan',
                 'Adam'    => 'Eve',
                 'Clyde'   => 'Bonnie',
                 'Sita'    => 'Gita',
                 'Haibath' => 'Gaibath',
   };

foreach my $sKey ( sort keys %$rhlPairs ) {
  print "Key [$sKey] Value [", $$rhlPairs { $sKey }, "]\n";
}

#---------------------------------------
# Reference to an anonymous subroutine..
#---------------------------------------
my $rlFHi = sub { print "Hi there @_!\n" };
$rlFHi->('once'); # Same as &$rlFHi ('once');
&$rlFHi ('twice');

#------------------------------------------------
# Calling sub-routines by reference, if defined..
#------------------------------------------------
print "Calling a sub-routine, if defined..\n";

my %hrSubs = ( 'sub6' => \&sub6,
               'sub7' => \&sub7,
               'sub8' => \&sub8,
               'sub9' => \&sub9,
               'sub10' => \&sub10
             );

my %hrData = ( 'sub6' => [ qw ( one two three four five ) ],
               'sub8' => [ ( 1 .. 10 ) ],
               'sub10' => \@liList
             );

my $iRef = 12;
my @liData1 = ( 1 .. 10 );
my @liData2 = ( 11 .. 20 );

@{ $hrData { sub7 } } = ( \$iRef, \@liData2 );
@{ $hrData { sub9 } } = ( ( \@liData1, \@liData2 ) );

#-----------------------------------------------
# Call each sub-routine, with args, if defined..
#-----------------------------------------------
foreach my $sSub ( qw ( sub6 sub7 sub8 sub9 sub10 sub11 ) ) {
  if ( $hrSubs { $sSub } ) {
    print "Calling sub-routine [$sSub]..\n";
    $hrSubs { $sSub }->( $hrData { $sSub } );
  }
  else {
    warn "Sub-routine [$sSub] has not been defined!\n";
  }
}

#----------------------------------------------
# Calling a sub-routine, embedded in a string..
#----------------------------------------------
print "\nCalled sub-routine sub1 within a print!\n@{[sub1 ('Hello World')]}\n";

#----------------------------------
# Using the *foo { THING } syntax..
#----------------------------------
my $refsub = * sub1;
print "Refsub [$refsub]\n";
&$refsub ( 'Anshuman Atre' );

my $rhlENV = * ENV { HASH };
foreach my $sKey ( sort keys %$rhlENV ) {
  print "Key [$sKey] Value [", $$rhlENV { $sKey }, "]\n";
}

#--------------------------
# Only sub-routines below..
#--------------------------
sub sub1 {
  my ( @list ) = @_; # All arguments passed a list..

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

  print "Passed [", join ( ' ', @list ), "]\n";
  2; # Should return 2..
}

sub sub6 {
  my ( $rlist ) = @_; # By reference..

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

  print "Passed [", join ( ' ', @$rlist ), "]\n";
  2; # Should return 2..
}

sub sub7 {
  my ( $rhlComp ) = @_;
  my ( $riNum, $rliList ) = @$rhlComp;

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

  print "Got Num [$$riNum] List [", @$rliList, "]\n";
  return 1;
}

sub sub8 {
  my ( $rliList ) = @_; # Oops!

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

  print "Got List [", @$rliList, "]\n";
  return 1;
}

sub sub9 {
  my ( $rhlComp ) = @_;
  my ( $rliList1, $rliList2 ) = @$rhlComp;

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called with [$rliList1][$rliList2]..\n";

  print "Got List1 [", join ( ' ', @$rliList1 ),
  "] List2 [", join ( ' ', @$rliList2 ), "]\n";

  return 1;
}

sub sub10 {

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

 foreach ( @_ ) {
   ++ $_;
 }

 return @_; # Heh.. heh..
}
