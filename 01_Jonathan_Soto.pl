#!perl
# Calculadora  en perl.
=pod
=head1
    POD - Plain Old Documentation, se usa para escribir documentación en Perl.
    Si se guarda un codigo como script.pl y se ejecuta usando perl script.pl, perl descartará cualquier cosa entre las 
    líneas =pod y =cut. Solo ejecutará el código real.
    Por otro lado, si ejecutas perldoc script.pl, el comando perldoc descartará todo el código. Obtendrá las líneas
    entre =pod y =cut, las formateará según ciertas reglas y mostrará el resultado en la pantalla. 
    La ventaja de usar documentación embebida POD es que tu código nunca carecerá de documentación por accidente,
    porque esta dentro de los propios modulos y scripts. 

    PRAGMA - Un pragma es un modulo que modifica algun aspecto del tiempo de compilacion, como lo son strict y warnings
=cut


use strict;
use warnings;
print "Dame A: ";
my $a=<STDIN>;
print "Dame B: ";
my $b=<STDIN>;

print "Que deseas hacer? \n";
print "1.- Sumar.\n";
print "2.- Restar.\n";
print "3.- Multiplicar.\n";
print "4.- Dividir.\n";
print "Opcion: ";

my $opcion=<STDIN>;

use Switch;

switch ($opcion)
{
    case 1 {print "El resultado de la  suma es: ",$a+$b}
    case 2 {print "EL resultado de la resta es: ", $a-$b}
    case 3 {print "El resultado de la multiplicacion es: ",$a*$b}
    case 4 {print "El resultado de la division es: ",$a/$b}
}
