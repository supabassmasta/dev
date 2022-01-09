public class STTOAUX extends ST{
  Gain gainl => outl;
  Gain gainr => outr;

  1. => gainl.gain => gainr.gain;

  fun void connect(ST @ tone, float g2main, float g2aux, int stnb) {
    // TO main
    tone.left() => gainl;
    tone.right() => gainr;
    g2main => gainl.gain => gainr.gain;

    // To AUX
    if (stnb != 0) {
      if ( stnb * 2 + 2 <= check_output_nb  ()  ){
        tone.left() => Gain auxl=> dac.chan(2*stnb);
        tone.right() => Gain auxr =>dac.chan(2*stnb + 1);
        g2aux => auxl.gain => auxr.gain;
      }
      else {
        <<<"ERROR:  STTOAUX, Not enough outputs to connect">>>;
      }
    }
    else {
      <<<"ERROR: STTOAUX, Stereo pair index 0 means main">>>;

    }
  }

  fun int check_output_nb  (){ 
     2 => int outnb; // By default assume there is two outputs

     FileIO fio;
     fio.open( "./output_numbers.txt", FileIO.READ );
     if( !fio.good() )
     {
        <<<"ERROR: STTOAUX: Can't open file output_numbers.txt in current dir">>>;
        <<<"                Assuming there is two outputs">>>;
        return 2;
     }

     fio => outnb;
     <<<"STTOAUX: output number: ", outnb>>>;
     return outnb;

  } 

}
