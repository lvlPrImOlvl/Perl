#!/usr/bin/perl -w
#USO: perl passwd2Tmpl <archivo_de_passwd>
use HTML::Template;
use warnings;
use strict;

my %hash;
my $output;
my $filename = $ARGV[0];
my @cont = ();

open FILE, "<" , $filename;
my $template = HTML::Template->new(filename => 'template.tmpl');

my @file = (<FILE>);
open FILE,">" , "prueba.html" or die "Error";
print FILE &test();
#root:x:0:0:root:/root:/bin/bash
print "Content-Type: text/html\n\n", $template->output;

sub test()
{
	for (@file)
	{
		my %hash;
		if(m{(.*):(.*):(.*):(.*):(.*):(.*):(.*)})
		{
			$hash{"USER"}=$1;
			$hash{"DATOS"}=$2.":".$3.":".$4.":".$5.":".$6.":".$7;
		}
		push(@cont, \%hash);
	}
	$template->param(THIS_LOOP => \@cont);
	$output.=$template->output();
}
close FILE;







