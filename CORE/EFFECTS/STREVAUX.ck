public class STREVAUX extends ST{
  STREV1 rev1;
  STTOAUX toaux;

  fun void connect(ST @ tone, float mix) {
    if ( check_output_nb() >= 4  ){
      toaux.connect(tone, 1. - mix, mix, 1);
      toaux.left() => outl;
      toaux.right() => outr;
    }
    else {
      <<<"STREVAUX: Not enough output, use STREV1 instead">>>;

      rev1.connect(tone, mix);
      rev1.left() => outl;
      rev1.right() => outr;
    }

  }


  fun int check_output_nb  (){ 
     2 => int outnb; // By default assume there is two outputs

     FileIO fio;
     fio.open( "./output_numbers.txt", FileIO.READ );
     if( !fio.good() )
     {
        return 2;
     }

     fio => outnb;
     // <<<"STTOAUX: output number: ", outnb>>>;
     return outnb;

  } 

}

