package Complex;

use overload "+"=>\&add,
    "-"=>"subtract",
    "&"=>"subReal",
    "|"=>\&addReal,
    "*"=> sub {
	      my $op1 = shift;
	      my $op2 = shift;

	      my $res_real = $op1->real * $op2->real;
	      my $res_img = $op1->img * $op2->img;

	      my $objref = {_real=>$res_real,
			    _img=>$res_img
			    };
	      bless $objref, Complex;
	      return $objref;
	  };


sub real {
    $num = shift;
    return $num->{_real};
}

sub img {
    $num = shift;
    return $num->{_img};
}

sub print {
    $num = shift;
    print $num->real, " + ", $num->img,"i\n";
}

sub new {
    my $class = shift;
    my $real_part = shift;
    my $img_part = shift;

    my $objref = {_real=>$real_part,
		  _img=>$img_part
		  };
    bless $objref, $class;
    return $objref;
}

sub add {
    my $op1 = shift;
    my $op2 = shift;

    my $res_real = $op1->real + $op2->real;
    my $res_img = $op1->img + $op2->img;

    my $objref = {_real=>$res_real,
		  _img=>$res_img
		  };
    bless $objref, Complex;
    return $objref;
}

sub subtract {
    my $op1 = shift;
    my $op2 = shift;

    my $res_real = $op1->real - $op2->real;
    my $res_img = $op1->img - $op2->img;

    my $objref = {_real=>$res_real,
		  _img=>$res_img
		  };
    bless $objref, Complex;
    return $objref;
}


sub subReal {
    my $op1 = shift;
    my $op2 = shift;
    my $reverse = shift;

    my $res_real = $op1->real - $op2;
#    if ($reverse == 1) {
#	print "\n***Operands have been reversed in subtract\n";
#	$res_real = -$res_real;
#    }

    my $res_img = $op1->img;

    my $objref = {_real=>$res_real,
		  _img=>$res_img
		  };
    bless $objref, Complex;
    return $objref;
}

sub addReal {
    my $op1 = shift;
    my $op2 = shift;
    my $reverse = shift;
    if ($reverse == 1) {
	print "\n***Operands have been reversed in add\n";
    }

    my $res_real = $op1->real + $op2;
    my $res_img = $op1->img;

    my $objref = {_real=>$res_real,
		  _img=>$res_img
		  };
    bless $objref, Complex;
    return $objref;
}

1;
