#!/usr/bin/perl -w
#ident "@(#) Sort hosts file in asending order of IPs.. Atre 10 Oct 2002"

$arrayName = -1;

while($line = <DATA>){
	chomp($line);
	# Starts with 3 hashes and ends with non space..
	if($line =~ /^###\s*\S+/){
		@line = split(/\s+/, $line, 2);
		$subnetName{++$arrayName} = $line[1];
		next;
	}
	# Get IPs.. Starts with 3 hashes and ends space..
	elsif($line && $line !~ /^#\s*/){
		@{$arrayName} = split(/\s+/, $line, 2);
		@octets = split(/\./, $${arrayName}[0], 4);

		for($i = 0; $i < 4; ++$i){
			if($octets[$i] < 10){
				$octets[$i] = "0" . $octets[$i];
			}

			if($octets[$i] < 100){
				$octets[$i] = "0" . $octets[$i];
			}

			$digitOfIp .= $octets[$i];
		}

		$digitOfIp =~ s/\.//g;

		# Hash with name = $arrayname, with key $digitOfIp..
		@${arrayName}{$digitOfIp} = $line;
		$digitOfIp = undef; # For next IP..
	}
}

#
# Display..
#

$str = "arr";
for($i = 0; $i <= $arrayName; ++$i){

	#
	# Sort ips within each subnet..
	#

	$val = $str . $i;
	@{$val} = sort {$a <=> $b} keys(%${i});
	$netHash{$${val}[0]} = $val;
}

@sortedSubnets = sort {$a <=> $b} keys(%netHash);

for($i = 0; $i < @sortedSubnets; ++$i){
	$val = $netHash{$sortedSubnets[$i]};
	### last char of val.. arr0 => 0.. holds the subnet name..
	$ar = substr($val, length($val) - 1, 1);
	printf("### %s\n", $subnetName{$ar});
	for($j = 0; $j < @{$val}; ++$j){
		printf("%s\n", ${$ar}{$$val[$j]});
	}
	printf("###\n\n");
}
__DATA__
### Development N/w
163.39.178.244	atre
163.39.178.24	tre
163.39.178.44	re
###

### UDEEG n/w
163.37.178.244	tot
163.37.178.54	bhaloo
163.37.178.144	ot
163.37.178.4	haloo
163.37.178.44	ot
163.37.178.14	aloo
###

### GDS n/w
63.35.179.40	iay tom		boy
63.35.179.49	ay om		oy
63.35.179.53	via to		bo
63.35.179.53	biay bom		coy
63.35.179.13	diay dom		doy
63.35.179.23	siay som		soy
63.35.179.43	viay vom		voy
###

### Production n/w
63.37.78.24	bigfoot
63.37.78.44	digfoot
63.37.78.4	eigfoot
63.37.78.14	figfoot
63.37.78.34	gigfoot
63.37.78.214	higfoot
63.37.78.224	igfoot
###

### Mystic n/w
16.57.17.24	chivdaa
###
