package Animal;

sub speak {
    my $animal = shift;
    print "a $animal goes ", $animal->sound," !\n";
}

1;
