package SSMG;

sub head {
    return "Rohit";
}

sub name {
    my $emp = shift;
    return $emp->{_name};
}

sub new {
    my $class = shift;
    my $name = shift;
    my $objref = {_name=>$name};
    bless $objref, $class;
    return $objref;
}
		  

1;
