package VCS;

@ISA = qw(SM Pune);

sub new {
    my $class = shift;
    my $name = shift;
    my $designation = shift;
    my $objref = {_name=>$name,
		  _designation=>$designation
		  };
    bless $objref, $class;
    return $objref;
}


1;
