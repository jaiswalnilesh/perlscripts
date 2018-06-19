#!/usr/bin/perl

use Complex;

my $num1 = Complex->new(2, 4);
my $num2 = Complex->new(3, 6);

print "Number1 = ";
$num1->print;
print "Number2 = ";
$num2->print;

my $num3 = $num1 + $num2;
my $num4 = $num2 - $num1;
my $num5 = $num1 * $num2;

print "Number3 (addition)  = ";
$num3->print;
print "Number4 (subtraction) = ";
$num4->print;
print "Number5 (multiplication) = ";
$num5->print;

my $num6 = $num1 & 10;
print "Number6 (subReal) = ";
$num6->print;

my $num7 = 10 & $num1;
print "Number7 (subReal with reverse) = ";
$num7->print;

my $num8 = $num1 | 10;
print "Number8 (addReal) = ";
$num8->print;

my $num9 = 10 | $num1;
print "Number9 (addReal with reverse ?) = ";
$num9->print;
