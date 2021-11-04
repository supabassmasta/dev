public class STHISHELF extends ST{
ST @ last;
STGAIN stgain;

STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;

  fun void connect(ST @ tone, float f, float q, int order, int channels, float g) {
    tone @=> last;

    sthpfx0.connect(last $ ST ,  sthpfx0_fact, f /* freq */ , q /* Q */ , order /* order */, channels /* channels */ );       sthpfx0 $ ST @=>  last;  

    g => sthpfx0.gain;

    stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last;
    stgain.connect(tone $ ST , 1. /* static gain */  );       stgain $ ST @=>  last;

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

