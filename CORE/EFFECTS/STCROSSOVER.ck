public class STCROSSOVER extends ST{
ST @ last;
STGAIN stgain;

STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;

  fun void connect(ST @ tone, float f, float q, int order, int channels, float g) {
    tone @=> last;

    sthpfx0.connect(tone $ ST ,  sthpfx0_fact, f /* freq */ , q /* Q */ , order /* order */, channels /* channels */ );       sthpfx0 $ ST @=>  last;  
    stlpfx0.connect(tone $ ST ,  stlpfx0_fact, f /* freq */ , q /* Q */ , order /* order */, channels /* channels */ );       stlpfx0 $ ST @=>  last;  

    g => stlpfx0.gain;

    stgain.connect(sthpfx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last;
    stgain.connect(stlpfx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last;

    if (channels == 1 ){
      stgain.left() => outl;
      stgain.left() => outr;
      stgain.right() => Gain trash;
    }
    else {
      stgain.left() => outl;
      stgain.right() => outr;
    }

  }

}


