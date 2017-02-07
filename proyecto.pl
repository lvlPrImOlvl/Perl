#!/usr/bin/perl
use strict;
use 5.014;
use Data::Dumper;

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

my $file = $ARGV[0];
open(LOG, '>>', "./log.txt") or die "No se ha podido crear el log: '$file' $!";
my %ips;
my $ip;
my $numip;

my %emails;
my $email;
my $numemail;

my %domainNames;
my $domainName;
my $numdomainName;

if (not defined $file)
{
	say "Uso: perl proyecto.pl <Nombre del archivo a analizar>";
	print LOG "$mday/$mon/$year $hour:$min:$sec\tSe ha intentado correr el programa con parametros inadecuados.\n";
}
else
{
	if (-e $file)
	{
		open(DATOS, '<', $file);
		print "Todo bien leyendo el archivo '$file'\n";

		while(<DATOS>)
		{
			chomp;
			if ($_ =~/[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*/)
			{
				$email = ($&)[0];
			  	$emails{$email}++;
			  	$numemail++;
			}
			# if ($_ =~/(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])/)
			# {
			# 	$ip = ($&)[0];
			# 	$ips{$ip}++;
			# 	$numip++;
			# }

			# if ($_ =~/([a-z]+|(www)).(\.[a-z0-9-]+([a-z]{2,3})*)/)
			# {
			# 	$domainName = ($&)[0];
			# 	$domainNames{$domainName}++;
			# 	$numdomainName++;

			# }
		}

		#print Dumper \%ips;
		say "\nNumero total de ips: '$numip'";
		print scalar(keys %ips),"\n";
		#print Dumper \%emails;
		say "\nNumero total de emails: '$numemail'";
		print scalar(keys %emails),"\n";
		print Dumper \%domainNames;
		say "\nNumero total de nombres de dominio: '$numdomainName'";
		print scalar(keys %domainNames),"\n";
	} 
	else
	{
		say "No se ha podido encontrar el archivo '$file', verifique la ruta.";
		print LOG "$mday/$mon/$year $hour:$min:$sec\tSe ha intentado abrir el archivo '$file' pero no se ha encontrado la ruta.\n";
	}
	
}
close DATOS;
close LOG;
