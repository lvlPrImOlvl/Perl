use warnings;
use strict;


my @primero= (1..10);
my @segundo= ();

foreach(@primero){

if (($_ % 2) == 0){
	push @segundo, $_;
	}
}

print "Resultado: \n";

print "primera matriz --> ", @primero;
print "\n";
print "segunda matriz--> ",@segundo;
print "\n\n";