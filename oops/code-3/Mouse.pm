package Mouse;
@ISA = qw(Animal);

sub sound { 
    return "squeak";
}

sub speak {
    my $animal = shift;
    $animal->Animal::speak;
    print "[but we can barely hear it !]\n";
    print "[It is $animal->{_color} in color]\n";
}

sub mynew {
    my $class = shift;
    my $name = shift;
    my $color = shift;
    my $objref = {_name=>$name,
		  _color=>$color
		  };
    
    bless $objref, $class;
    return $objref;
}

1;
