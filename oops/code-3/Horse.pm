package Horse;
@ISA = qw(Animal);

sub sound {
    return "neigh" ;
}

sub speak {
    my $animal = shift;
    print "Horse $$animal cannot run while speaking !\n";
}

sub new {
    my $class = shift;
    my $name = shift;
    
    return bless \$name, $class;
}

1;
