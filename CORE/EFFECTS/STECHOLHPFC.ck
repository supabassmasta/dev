  class control_gain extends CONTROL {
    Delay @ dlp;
    Delay @ drp;

    1 => update_on_reg ;
    
    fun void set (float in) {
      in / 100. =>  dlp.gain => drp.gain;
      <<<"control_gain ", dlp.gain()>>>;

    }
  }

  class control_freq extends CONTROL {
    LPF @ fl;
    LPF @ fr;
    HPF @ hl;
    HPF @ hr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      float f;

      if ( in < 64  ){
        // Open HPF
        10 => hl.freq => hr.freq;

        Std.mtof(in * 2) => f;
        if (f>19000) {
          <<<"LPF control_freq TOO HIGH:", f>>>;
          19000 => fl.freq => fr.freq;
        }
        else if (f< 10) {
          <<<" LPF control_freq TOO LOW:", f>>>;
          10 => fl.freq => fr.freq;
        }
        else {
          f => fl.freq => fr.freq;
          <<<"LPF control_freq ", fr.freq()>>>; 
        }
      }
      else {
        // Open LPF
        19000 => fl.freq => fr.freq;
        Std.mtof((in - 64) * 2) => f;
        if (f>19000) {
          <<<"HPF control_freq TOO HIGH:", f>>>;
          19000 => hl.freq => hr.freq;
        }
        else if (f< 10) {
          <<<" HPF control_freq TOO LOW:", f>>>;
          10 => hl.freq => hr.freq;
        }
        else {
          f => hl.freq => hr.freq;
          <<<"HPF control_freq ", hr.freq()>>>; 
        }



      }
    }

  }

  class control_q extends CONTROL {
    LPF @ fl;
    LPF @ fr;
    HPF @ hl;
    HPF @ hr;
    1 => update_on_reg ;
    
    fun void set (float in) {
      1. + in/16. => fl.Q => fr.Q => hl.Q => hr.Q;

      <<<"control_Q ", fr.Q()>>>; 
    }
  }

public class STECHOLHPFC extends ST{
  Gain fbl => outl;
  fbl => Delay dl => LPF lpfl => HPF hpfl => Dyno dyl => fbl;
                                                         
  Gain fbr => outr;                                      
  fbr => Delay dr => LPF lpfr => HPF hpfr => Dyno dyr => fbr;

  dyl.limit();
  0.0 => dyl.slopeAbove;

  dyr.limit();
  0.0 => dyr.slopeAbove;

  0. =>  dl.gain => dr.gain;
  data.tick => dl.max => dl.delay => dr.max => dr.delay;

  control_gain cgain;
  dr @=> cgain.drp; 
  dl @=> cgain.dlp; 



  1000 => lpfl.freq;
  1000 => lpfr.freq;
  1 => lpfl.Q;
  1 => lpfr.Q;

  0 => hpfl.freq;
  0 => hpfr.freq;
  1 => hpfl.Q;
  1 => hpfr.Q;

  control_freq cfreq;
  lpfl @=> cfreq.fl;
  lpfr @=> cfreq.fr;
  hpfl @=> cfreq.hl;
  hpfr @=> cfreq.hr;

  control_q cq;
  lpfl @=> cq.fl;
  lpfr @=> cq.fr;
  hpfl @=> cq.hl;
  hpfr @=> cq.hr;

  END_CONTROL endf;
  END_CONTROL endq;
  END_CONTROL endg;

  0 => int connected;

  fun void connect(ST @ tone, CONTROLER f, CONTROLER q, dur d, CONTROLER g) {
    tone.left() => fbl;
    tone.right() => fbr;

    if (!connected) {
      g.reg(cgain);
      endg.conf(endg, g,cgain);

      d => dl.max => dl.delay => dr.max => dr.delay;


      f.reg(cfreq);
      endf.conf(endf, f ,cfreq);
      if(q != NULL){
        q.reg(cq);
        endq.conf(endq, q ,cq);
      }
      1 =>  connected;
    }

  }

  // Track filter max value
  fun void f1 (){ 
    0 => float max;
    0 => float max2;
    now => time t;
    while(1) {
      if ( lpfl.last() > max  ){
        lpfl.last() => max;
      }

      if ( hpfl.last() > max2  ){
        hpfl.last() => max2;
      }

      if ( t + 1000::ms < now  ){
        <<<"MAX at LPF: ", max, " HPF:", max2>>>;

        now => t;
        0 => max;
        0 => max2;
      }
      1::samp => now;
    }
  } 
//  spork ~ f1 ();
      


}


