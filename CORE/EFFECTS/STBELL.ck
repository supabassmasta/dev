public class STBELL extends ST{
ST @ last;
STGAIN stgain;
STFILTERX stbpfx0;
BPF_XFACTORY stbpfx0_fact;

  fun void connect(ST @ tone, float f, float q, int order, int channels, float g) {
    tone @=> last;
    stbpfx0.connect(last $ ST ,  stbpfx0_fact, f /* freq */ , q /* Q */ , order /* order */, channels /* channels */ );       stbpfx0 $ ST @=>  last;  

    g => stbpfx0.gain;

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
