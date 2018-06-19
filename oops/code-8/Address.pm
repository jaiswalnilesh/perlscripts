package Address;


sub new {
    my $class = shift;
    my $house_number = shift;
    my $street = shift;
    my $city = shift;

    my $objref = {_house=>$house_number,
		  _street=>$street,
		  _city=>$city
		  };
    bless $objref, $class;
    return $objref;
}

sub print_address {
    $addr = shift;
    print "House: ", $addr->{_house},"\n";
    print "Street: ", $addr->{_street},"\n";
    print "City: ", $addr->{_city},"\n";
}


1; 
