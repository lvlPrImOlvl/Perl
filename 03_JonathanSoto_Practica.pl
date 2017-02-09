my $cmd;
my @resultado=();
my %HoF = (                           # Compose a hash of functions
    salir   =>  sub { for (@resultado)
                      {
                          print "Resultado : ", $_,"\n";
                      }
                      
                      exit
                     },
    suma    =>  \&suma,
    resta   =>  \&resta,
    multi   =>  \&multi,
    divi    =>  \&divi,
    mod     =>  sub{ 
                  my $a=shift;
                  my $b=shift;
                  push @resultado, $a%$b; 
                   },
    help    =>  sub{ print "la opciones son la siguientes:\nsuma\nresta\nmulti\ndivi\nmod\nsalir\n"},
);
while(1){

 $cmd=<STDIN>;
 @res = split " " ,$cmd;
  #convertir a minusculas y comparar con el hash
   if($HoF{lc $res[0]}){
    #se pasan los argumentos si el if es diferente de 0
    $HoF{lc $res[0]}->($res[1],$res[2]);
   }
   else {
    warn "Unknown command: `$cmd'; Try `help' next time\n";
   }
}


sub suma{
   my $a=shift;
   my $b=shift;
   
   push @resultado, $a+$b;
   }
sub resta{
   my $a=shift;
   my $b=shift;
   push @resultado, $a-$b;
}
sub multi{
   my $a=shift;
   my $b=shift;
   push @resultado, $a*$b;
}
sub divi{
  my $a=shift;
  my $b=shift;
  if($b > 0){
      push @resultado, $a/$b;
  }
  else {
    print "No hay division entre cero, vuelve a intentarlo!!\n\n";
  }

}