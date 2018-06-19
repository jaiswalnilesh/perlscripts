package Cow;
@ISA = qw(Animal);

sub sound { 
    my $animal = shift;
    my $sound = "$animal->{_color}"." Moo";
    return $sound;
}
1;
