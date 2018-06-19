package Horse;
@ISA = qw(Animal);

sub sound {
    return "neigh" ;
}

sub speak {
    my $animal = shift;
    $animal->SUPER::speak;
    print "[but it cannot run while speaking !]\n";
}
1;
