package Goat;
@ISA = qw(Animal);

sub sound {
    return "Maaa" ;
}

sub speak {
    my $animal = shift;
    print "$animal ke pass ", $animal->sound, " hai !\n";
}

1;
