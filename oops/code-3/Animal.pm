package Animal;

sub speak {
    my $animal = shift;
    print "$animal->{_name} goes ", $animal->sound," !\n";
}

1;
