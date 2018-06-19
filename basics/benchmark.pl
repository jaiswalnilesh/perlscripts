#!/opt/VRTSperl/bin/perl

use Benchmark;

my $iCnt = 0;
my $sStr = "anshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatreanshumanatre";

=pod
&timethese ( 500000000,
            { 'method1' => q{ $iCnt = $sStr =~ tr/a// },
              'method2' => q{ $iCnt = $sStr =~ s/a/a/g }
            } );
=cut
#=pod
#$iCnt = $sStr =~ tr/a//;
$iCnt = $sStr =~ s/a/a/g;
print "String [$sStr] a-cnt: $iCnt\n";
#=cut
