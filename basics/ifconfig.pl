#!/usr/bin/perl -w
#ident "@(#) Parse ifconfig output on Solaris.. Atre 07 Feb 2008"

my ( $sKey, $sVal, %hsNICs ) = ();
my @lsData = grep {                     # Grep after..
               ( s/\n// || 1 )       && # Chomp and make true..
               s/^(\w+).*/$1/        || # Catch the NIC or.. 
               s/.*inet\s(\S+).*/$1/    # The IP address..
             } <DATA>;

while ( ( $sKey, $sVal ) = splice ( @lsData, 0, 2 ) ) {
  push @{ $hsNICs { $sKey } }, $sVal;
}

foreach $sKey ( sort keys %hsNICs ) {
  print "NIC [$sKey] IPs [",
  join ( '][', @{ $hsNICs { $sKey } } ), "]\n";
}
__DATA__
lo0: flags=1000849<UP,LOOPBACK,RUNNING,MULTICAST,IPv4> mtu 8232 index 1
        inet 127.0.0.1 netmask ff000000
bge0: flags=1000843<UP,BROADCAST,RUNNING,MULTICAST,IPv4> mtu 1500 index 2
        inet 10.212.98.58 netmask fffffe00 broadcast 10.212.99.255
        ether 0:3:ba:e7:e7:19
bge0:1: flags=1000843<UP,BROADCAST,RUNNING,MULTICAST,IPv4> mtu 1500 index 2
        inet 10.212.98.65 netmask fffffe00 broadcast 10.212.99.255
bge0:2: flags=1000843<UP,BROADCAST,RUNNING,MULTICAST,IPv4> mtu 1500 index 2
        inet 10.212.98.118 netmask ff000000 broadcast 10.255.255.255
bge0:3: flags=1000843<UP,BROADCAST,RUNNING,MULTICAST,IPv4> mtu 1500 index 2
        inet 10.212.98.12 netmask fffffe00 broadcast 10.212.99.255
