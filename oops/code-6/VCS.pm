package VCS;

@ISA = qw(SM);

sub head {
    return "Neel";
}

sub name {
    my $emp = shift;
    return $emp->{_name};
}

1;
