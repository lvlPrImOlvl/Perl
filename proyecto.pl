#!/usr/bin/perl
use strict;
use 5.014;
use Data::Dumper;
=pod
 
=head1 DESCRIPCION

El script funciona pasandole como argumento un archivo de texto (.txt) para que pueda analizarlo y obtener:
*IPS
*Nombres de dominio
*Emails
*URLS
 
USO:

perl proyecto.pl <archivo_a_analiza.txt>
=cut

=pod
Se utilizaron las variables ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) para manejar la hora en que ocurrian los eventos
=cut
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

#Variable utlizada para obtener el nombre del archivo que ingresa por medio de linea de comandos
my $file = $ARGV[0];

#Variables utilizadas para el conteo de cada tipo de busqueda

my %ips;
my $ip;
my $numip;

my %emails;
my $email;
my $numemail;

my %domainNames;
my $domainName;
my $numdomainName;

my %urls;
my $url;
my $numurl;

my $llave;
my $valor;

#Se crea el archivo log para ir ingresando los eventos importantes 
open(LOG, '>>', "./log.txt") or die "No se ha podido crear el log: '$file' $!";

#Si no esta definido el argumento el programa finaliza mostrando un mensaje de como usarlo y agregando un evento al log
if (not defined $file)
{
	say "Uso: perl proyecto.pl <Nombre del archivo a analizar>";
	print LOG "$mday/$mon/$year $hour:$min:$sec\tSe ha intentado correr el programa con parametros inadecuados.\n";
}
else
{
	#Si el usuario si ingreso un argumento, y este existe, el programa procede, si no, agrega un evento al log
	if (-e $file)
	{
		#Abre el archivo de lectura
		open(DATOS, '<', $file);
		print "Se esta analizando el archivo '$file', por favor espere...\n";

		#Empieza el analisis
		while(<DATOS>)
		{	
			chomp;


			if ($_ =~/(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])/)			
			{
				$ip = ($&)[0];
				$ips{$ip}++;
				$numip++;
			}

			if ($_ =~ /([a-zA-Z0-9-]+)([a-zA-Z0-9-]+)@([a-zA-Z0-9-]+)[.]*([a-zA-Z0-9-]*)[.]*([a-zA-Z0-9-]*)/)
			{
			 	$email = ($&)[0];
			    $emails{$email}++;
			    $numemail++;
			}

			if ($_ =~/([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}[^.jpg]$/) 
			{
			 	$domainName = ($&)[0];
			 	$domainNames{$domainName}++;
			 	$numdomainName++;
			}

			if ($_ =~/(((http|ftp|https|www|sftp):\/{2})+(([0-9a-z_-]+\.)+(aero|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|ac|ad|ae|af|ag|ai|al|am|an|ao|aq|ar|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|co|cr|cu|cv|cx|cy|cz|cz|de|dj|dk|dm|do|dz|ec|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|in|io|iq|ir|is|it|je|jm|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mk|ml|mn|mn|mo|mp|mr|ms|mt|mu|mv|mw|mx|my|mz|na|nc|ne|nf|ng|ni|nl|no|np|nr|nu|nz|nom|pa|pe|pf|pg|ph|pk|pl|pm|pn|pr|ps|pt|pw|py|qa|re|ra|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tf|tg|th|tj|tk|tl|tm|tn|to|tp|tr|tt|tv|tw|tz|ua|ug|uk|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|ye|yt|yu|za|zm|zw|arpa)(:[0-9]+)?((\/([~0-9a-zA-Z\#\+\%@\.\/_-]+))?(\?[0-9a-zA-Z\+\%@\/&\[\];=_-]+)?)?))\b/)
			{
			  	$url = ($&)[0];
			  	$urls{$url}++;
			  	$numurl++;
			}
		}

		#Se intenta abrir el archivo de resultados
		open(RESULTADOS, '>', "./resultados.txt") or die "No se ha podido crear el archivo de resultados: '$file' $!";
		print LOG "$mday/$mon/$year $hour:$min:$sec\tFinalizo el analisis de '$file' exitosamente.\n";
		####Descomentar para ver resultados en pantalla####
		#print Dumper \%ips;
		#print Dumper \%emails;
		#print Dumper \%urls;
		#print Dumper \%domainNames;

		########################IMPRESIONES DE RESULTADOS EN EL ARCHIVO RESULTADOS.TXT########################
		##########IMPRESION DE IPS##########
		say "\nNumero total de ips: '$numip'\n";
		print "\nNumero total de ips diferentes: ",scalar(keys %ips),"\n";
		print RESULTADOS "Numero total de ips: '$numip'\n";
		print RESULTADOS "Numero total de ips diferentes: ",scalar(keys %ips),"\n";
		while (($llave,$valor) = each %ips)
		{
			print RESULTADOS "$llave | $valor\n";
		}

		##########IMPRESION DE EMAILS##########
		say "\nNumero total de emails: '$numemail'\n";
		print "\nNumero total de emails diferentes: ",scalar(keys %emails),"\n";
		print RESULTADOS "\nNumero total de emails: '$numemail'\n";
		print RESULTADOS "Numero total de emails diferentes: ",scalar(keys %emails),"\n";
		while (($llave,$valor) = each %emails)
		{
			print RESULTADOS "$llave | $valor\n";
		}

		##########IMPRESION DE URLS##########
		say "\nNumero total de urls: '$numurl'\n";
		print "\nNumero total de urls diferentes: ",scalar(keys %urls),"\n";
		print RESULTADOS "\nNumero total de urls: '$numurl'";
		print RESULTADOS "Numero total de urls diferentes: ",scalar(keys %urls),"\n";
		while (($llave,$valor) = each %urls)
		{
			print RESULTADOS "$llave | $valor\n";
		}

		##########IMPRESION DE DOMINIOS##########
		say "\nNumero total de nombres de dominio: '$numdomainName'\n";
		print "\nNumero total de nombres de dominio diferentes: ",scalar(keys %domainNames),"\n";
		print RESULTADOS "\nNumero total de nombres de dominio: '$numdomainName'";
		print RESULTADOS "Numero total de nombres de dominio diferentes: ",scalar(keys %domainNames),"\n";
		while (($llave,$valor) = each %domainNames)
		{
			print RESULTADOS "$llave | $valor\n";
		}

	} 
	else
	{
		say "No se ha podido encontrar el archivo '$file', verifique la ruta.";
		print LOG "$mday/$mon/$year $hour:$min:$sec\tSe ha intentado abrir el archivo '$file' pero no se ha encontrado la ruta.\n";
	}
	
}
close DATOS;
close LOG;
