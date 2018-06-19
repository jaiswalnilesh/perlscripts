sub UNIVERSAL::univ_method {
    print "I am in Debug\n";
}

package Pune;
use strict;

sub head {
    return "Shantanu";
}

sub sendToBaner {
    #dummy function;
    print "\nsending to Baner\n";
}

sub name {
    my $emp = shift;
    my $str = "Shri ".$emp->{_name};

}

1;
