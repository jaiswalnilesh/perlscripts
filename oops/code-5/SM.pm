package SM;

@ISA = qw(SSMG);

sub head {
    $obj = shift;
    $str = $obj->SUPER::head . " & Indira";
    return $str;
}

sub sendToMV {
    #dummy function;
    print "\nSending to MV\n";
}

1;
