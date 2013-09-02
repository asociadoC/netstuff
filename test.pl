#!/usr/bin/perl

use Getopt::Long; 
use NetAddr::IP;
 
# my $ipAddr  = "192.168.1.3";
# ich
my $ipAddr  = $ARGV[0];
# /ich
#my $netAddr = "192.168.1.0/29"; # 192.168.1.0 - 192.168.1.7
 
#my $network  = NetAddr::IP->new($netAddr);
#my $network  = NetAddr::IP->new("192.168.1.0", "255.255.255.248");
#my $network  = NetAddr::IP->new("192.168.1.0", "29");
#my $network  = NetAddr::IP->new("192.168.1.0-192.168.1.7");
# ich
my $network  = NetAddr::IP->new($ARGV[1]);
# /ich

my $ip = NetAddr::IP->new($ipAddr);
 
if ($ip->within($network)) {
        print $ip->addr() . " is in same subnet\n";
	exit 0
}
else {
        print $ip->addr() . " is outside the subnet\n";
	exit 1
}
