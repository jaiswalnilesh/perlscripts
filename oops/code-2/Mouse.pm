package Mouse;
@ISA = qw(Animal);

sub sound { 
    return "squeak";
}

sub speak {
    my $animal = shift;
    $animal->Animal::speak;
    print "[but we can barely hear it !]\n";
}
1;
