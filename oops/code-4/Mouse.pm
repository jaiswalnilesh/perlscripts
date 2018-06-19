package Mouse;
@ISA = qw(Animal);

my $_count=0;

sub incr_count {
    $_count++;
}

sub decr_count {
    $_count--;
}

sub count {
    return $_count;
}

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
    incr_count();
    return $objref;
}

sub DESTROY {
    my $animal=shift;
    print "In destructor for ", $animal->{_name}, "\n";
    decr_count();
}

sub END {
    print "End of the Mouse class\n";
}

1;
