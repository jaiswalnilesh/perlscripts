package Animal;

sub speak {
    my $animal = shift;
    print "$animal->{_name} goes ", $animal->sound," !\n";
}

sub END {
    print "End of the Animal class\n";
}

1;
