#!/usr/bin/perl
use warnings;
use strict;

my $num1;
my $num2;
my $opcion;
sub menu
{
do
{
  print "Que operacion deseas hacer?\n1.-Suma\n2.-Resta\n3.-Multiplicacion\n4.-Division\nOpcion:";
  chomp ( $opcion = <STDIN>);
  exit 0 if $opcion eq 5;
  print "\nIngresa el primer numero: ";
  chomp ( $num1 = <STDIN>);
  print "\nIngresa el segundo numero: ";
  chomp ( $num2 = <STDIN>);

   use Switch;
   
  switch ($opcion)
  {
    case 1 {&suma();}
    case 2 {&resta();}
    case 3 {&multiplicacion();}
    case 4 {&division();}
  }
  }while ($opcion != 5)
}

sub suma
{
print $num1 + $num2;
}

sub resta
{
print $num1 - $num2;
}

sub multiplicacion
{
print $num1 * $num2;
}

sub division
{
  if ($num2 != 0)
  {
    print $num1 / $num2;
  }
  else
  {
    print "Error\n";
  }
}

&menu();
