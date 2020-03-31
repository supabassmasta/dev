  class control_gain extends CONTROL {
    Delay @ dlp;
    Delay @ drp;

    1 => update_on_reg ;
    
    fun void set (float in) {
      in / 100. =>  dlp.gain => drp.gain;
      <<<"control_gain ", dlp.gain()>>>;

    }
  }

  class control_delay extends CONTROL {
    Delay @ dlp;
    Delay @ drp;
    
    1 => update_on_reg ;

    fun void set (float in) {
      <<<"control_delay ", in + 1, " * data.tick / 8.">>>;

       (in + 1) * data.tick / 8. =>  dlp.max => dlp.delay => drp.max => drp.delay; 
    }
  }
  
public class STECHOC0 extends ST{

  Gain fbl => outl;
  fbl => Delay dl => fbl;

  Gain fbr => outr;
  fbr => Delay dr => fbr;

  0. =>  dl.gain => dr.gain;
  data.tick => dl.max => dl.delay => dr.max => dr.delay;

  control_gain cgain;
  dr @=> cgain.drp; 
  dl @=> cgain.dlp; 

  //  control_delay cdelay;
  //  dr @=> cdelay.drp; 
  //  dl @=> cdelay.dlp; 
  END_CONTROL endg;

  0 => int connected;

  fun void connect(ST @ tone, dur d, CONTROLER g) {
    tone.left() => fbl;
    tone.right() => fbr;

    if (!connected) {
      //    d.reg(cdelay);
      g.reg(cgain);
      endg.conf(endg, g ,cgain);
      d => dl.max => dl.delay => dr.max => dr.delay;
      1 =>  connected;
    }

  }

}

