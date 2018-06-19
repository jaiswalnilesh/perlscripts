#!/usr/bin/perl -w

use strict;
use Socket;

sub usage {
  warn "usage: $0 <port> <host>\n";
  exit 1;
}

&usage () unless 2 == scalar @ARGV;

my ( $remote, $port, $iaddr, $paddr, $proto, $line) = ();

$port    = shift || 2345;  # random port
$remote  = shift || 'localhost';

if ($port =~ /\D/) { $port = getservbyname($port, 'tcp') }
die "No port" unless $port;
$iaddr   = inet_aton($remote)               || die "no host: $remote";
$paddr   = sockaddr_in($port, $iaddr);

$proto   = getprotobyname('tcp');
socket(SOCK, PF_INET, SOCK_STREAM, $proto)  || die "socket: $!";
connect(SOCK, $paddr)    || die "connect: $!";

print "Reading from server --\n";
while (defined($line = <SOCK>)) {
  print $line;
}

close ( SOCK ) ||
die "close: $!";
