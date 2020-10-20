class control_freq extends CONTROL {
  FILTERX_PATH @ fp;
  1 => update_on_reg ;
  
  fun void set (float in) {
    Std.mtof(in) => fp.freq;
  }

}

class control_q extends CONTROL {
  FILTERX_PATH @ fp;
  1 => update_on_reg ;

  fun void set (float in) {
    1. + in/16. => float q;
    fp.Q(q);

    <<<"control_Q ", q>>>; 
  }
}

public class STFILTERXC extends ST{
  FILTERX_PATH fpath;
  // Enable Filter LIMITS
  1 => fpath.enable_limit;

  control_freq cfreq;
  fpath @=> cfreq.fp;

  control_q cq;
  fpath @=> cq.fp;

  END_CONTROL endf;
  END_CONTROL endq;

  0 => int connected;

  fun void connect(ST @ tone, FILTERX_FACTORY @ factory,  CONTROLER f, CONTROLER q, int order, int channels) {
    fpath.build(channels,  order, factory);

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

    if (!connected) {
      f.reg(cfreq);
      endf.conf(endf, f ,cfreq);
      if(q != NULL){
        q.reg(cq);
        endq.conf(endq, q ,cq);
      }
      1 =>  connected;
    }
  }
}


