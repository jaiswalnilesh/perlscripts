#!/usr/bin/perl

use Animal;
use Mouse;

{
    print "Number of mice is = ", Mouse::count(), "\n";
    sleep(2);
    my $mouse1 = Mouse->mynew("Stuart Little", "white");
    $mouse1->speak();
    print "Number of mice is = ", Mouse::count(), "\n";
    sleep(2);
    my $mouse4 = Mouse->mynew("Stuart Little4", "white");
    $mouse4->speak();
    print "Number of mice is = ", Mouse::count(), "\n";
    sleep(2);
    print "End of block 1\n";
}
print "Number of mice is = ", Mouse::count(), "\n";
sleep(2);
my $mouse2 = Mouse->mynew("Stuart Little2", "white");
$mouse2->speak();
print "Number of mice is = ", Mouse::count(), "\n";
my $mouse3 = Mouse->mynew("Stuart Little3", "white");
$mouse3->speak();
print "Number of mice is = ", Mouse::count(), "\n";

