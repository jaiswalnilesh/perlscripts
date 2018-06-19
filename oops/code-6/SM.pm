package SM;

@ISA = qw(SSMG);

sub head {
    return "Indira";
}

sub name {
    my $emp = shift;
    return $emp->{_name};
}

sub act {
    my $emp = shift;
    print "Head of the SM Organization is ", $emp->head(), "\n";

}

1;
