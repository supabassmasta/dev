public class STFILTER extends ST{
  FILTERX_PATH fpath;

  fun void connect(ST @ tone, FILTERX_FACTORY @ factory, float f, float q, int order, int channels) {
    fpath.build(channels,  order, factory);
     fpath.freq(f);
     fpath.Q(q);
   
     if ( channels == 1  ){
         tone.left() => fpath.in[0];
         tone.right() => Gain trash;
         fpath.out[0] => outl;
         fpath.out[0] => outr;
     }
     else if (channels > 1) {
        tone.left() => fpath.in[0];
        tone.right() => fpath.in[1];
 
        fpath.out[0] => outl;
        fpath.out[1] => outr;
     }
  }

}


