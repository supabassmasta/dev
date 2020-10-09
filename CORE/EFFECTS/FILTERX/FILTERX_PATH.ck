public class FILTERX_PATH {
  Gain in[0];
  Gain out[0];
  
  FILTERX  fx[0];
  FILTERX_FACTORY @ fact;
  0 => int channels;
  0 => int order;
  0 => int enable_limit;

  fun void freq(float in) {
    if ( enable_limit ){
        if ( in < fx[0].min || in > fx[0].max  ){
          // OUT of range 
          return;
        }
    }

    for (0 => int i; i <   fx.size()    ; i++) {
      fx[i].freq(in);
    }

  }

  fun void Q (float in) {
    for (0 => int i; i <   fx.size()    ; i++) {
      fx[i].Q(in);
    }
  }


  fun void build (int chans, int orderr, FILTERX_FACTORY @ factory ) {
    UGen @ last;

    chans => channels;
    orderr => order;
    factory @=> fact;

    for (0 => int i; i < channels ; i++) {
      in << new Gain;
      out << new Gain;
    }

    for (0 => int i; i < channels ; i++) {
      in[i] $ UGen @=> last;
      for (0 => int j; j < order ; j++) {
         fx << fact.create();
         // connect
         last => fx[fx.size() - 1];
         // Save last created as last
         fx[fx.size() - 1] $ UGen @=> last;
      }
      // connect out  
      last => out[i];
    }
  }

}
