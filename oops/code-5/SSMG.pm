package SSMG;

sub head {
    return "Rohit";
}

sub name {
    my $emp = shift;
    return $emp->{_name};
}

1;
