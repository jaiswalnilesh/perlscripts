#!/usr/bin/perl -w

use strict;

#
# Define variables..
#
my $SENDMAIL = "/usr/lib/sendmail";
my $toAddress = "firtname_lastname\@symantec.com";
my $fromAddress = "batman\@gothamcity.com";
my $stat = undef;

my $message = sprintf << "EOF";
To: $toAddress
From: Batman <$fromAddress>
Cc:  Anshuman Atre <$toAddress>
Subject: Where's the party tonight?

Hi,

If you got this, you aren't invited!

Cheers!
Batman

EOF

if($stat = send_mail($message)){
	print "Mail sent..\n";
}
else{
	die "Mail could not be sent..\n";
}


#
# Postman.. :)
#

sub send_mail {

	my ($message) = @_;
	local *MAILHANDLE;

	open (MAILHANDLE, "|$SENDMAIL -oi -t") ||
	die ("send_mail: Could not open $SENDMAIL..: $!");

	$| = 1;
	chomp($message);
	print MAILHANDLE "$message\n";

	close (MAILHANDLE) ||
	die ("send_mail: Could not close $SENDMAIL..: $!");

	return (1);
}
