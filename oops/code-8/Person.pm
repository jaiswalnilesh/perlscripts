package Person;

use Address;

sub new {
    my $class = shift;
    my $name = shift;
    my $house_number = shift;
    my $street = shift;
    my $city = shift;

    my $address = Address->new($house_number, $street, $city);
    my $objref = {_name=>$name,
		  _address=>$address
		  };
    bless $objref, $class;
    return $objref;
}

sub new_with_addr {
    my $class = shift;
    my $name = shift;
    my $address = shift;

    my $objref = {_name=>$name,
		  _address=>$address
		  };
    bless $objref, $class;
    return $objref;
}

sub print_person {
    $person = shift;
    print "Name: ",$person->{_name},"\n";
    print "Address: \n";
    $person->{_address}->print_address();
}

sub print_addr {
    $per = shift;
    $per->{_address}->print_address();
}
1;
