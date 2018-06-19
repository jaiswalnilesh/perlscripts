#!/usr/bin/perl

use VCS;
use SM;
use SSMG;
use Pune;

my $name = "Pune Courier";
my $obj=\$name;

bless $obj, Pune;

my $send = $obj->can("sendToBaner") || $obj->can("sendToMV");
if ($send) {
    print "$$obj ";
    $obj->$send();
} else {
    print "$$obj ";
    print "\nCannot send anywhere\n";
}


sleep(2);
print "\n********************\n";
my $name = "SM Courier";
my $obj=\$name;

bless $obj, SM;

my $send = $obj->can("sendToBaner") || $obj->can("sendToMV");
if ($send) {
    print "$$obj ";
    $obj->$send();
} else {
    print "$$obj ";
    print "\nCannot send anywhere\n";
}


sleep(2);
print "\n********************\n";
my $name = "SSMG Courier";
my $obj=\$name;

bless $obj, SSMG;

my $send = $obj->can("sendToBaner") || $obj->can("sendToMV");
if ($send) {
    print "$$obj ";
    $obj->$send();
} else {
    print "$$obj ";
    print "\nCannot send anywhere\n";
}

sleep(2);
print "\n********************\n";
my $name = "VCS Courier";
my $obj=\$name;

bless $obj, VCS;

my $send = $obj->can("sendToMV") || $obj->can("sendToBaner");
if ($send) {
    print "$$obj ";
    $obj->$send();
} else {
    print "$$obj ";
    print "\nCannot send anywhere\n";
}
print "\n********************\n";
