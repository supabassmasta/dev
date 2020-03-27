class params {
  20000. => float lpffreq;
  1. => float lpfq;
  0. => float hpffreq;
  1. => float hpfq;
  [0., 0.] @=> float brffreq[];
  [1., 1.] @=> float brfq[];
  [0., 0.] @=> float bpffreq[];
  [1., 1.] @=> float bpfq[];
  [0., 0.] @=> float bpfg[];
  1. => float outgain;

  fun void print (){
    <<<"steq.static_connect(last $ ST, ",hpffreq," /* HPF freq */, ",hpfq," /* HPF Q */, ",lpffreq," /* LPF freq */, ",lpfq," /* LPF Q */
      , ",brffreq[0]," /* BRF1 freq */, ",brfq[0]," /* BRF1 Q */, ",brffreq[1]," /* BRF2 freq */, ",brfq[1]," /* BRF2 Q */
      , ",bpffreq[0]," /* BPF1 freq */, ",bpfq[0]," /* BPF1 Q */, ",bpfg[0]," /* BPF1 Gain */
      , ",bpffreq[1]," /* BPF2 freq */, ",bpfq[1]," /* BPF2 Q */, ",bpfg[1],"  /* BPF2 Gain */
      , ",outgain," /* Output Gain */ ); steq $ ST @=>  last;">>>;
  }
}

class contlpffreq extends CONTROL {
  LPF @ fl;
  LPF @ fr;
  Gain @ ginl;
  Gain @ goutl;
  Gain @ ginr;
  Gain @ goutr;
  params @ ps;

  0 => int active;

  0 =>  update_on_reg ;

  fun void set(float in) {
    if ( ! active  ){
      1 => active;
      ginl =< goutl;
      ginl => fl => goutl;
      ginr =< goutr;
      ginr => fr => goutr;
    }

    float f;
    Std.mtof(in*1.1) => f;
    if (f>19999) {
      <<<"control_freq TOO HIGH:", f>>>;
      19999 => f;
    }
    else if (f< 10) {
      <<<"control_freq TOO LOW:", f>>>;
      10 => f;
    }
    f => fl.freq => fr.freq;
    <<<"control_freq ", fr.freq()>>>; 
    f => ps.lpffreq;
    ps.print();
  }
    
}

  class contlpfq extends CONTROL {
    LPF @ fl;
    LPF @ fr;
    params @ ps;
    0 => update_on_reg ;
    
    fun void set (float in) {
      1. + in/16. => fl.Q => fr.Q;

      <<<"control_Q ", fr.Q()>>>; 
      fr.Q() @=> ps.lpfq;
      ps.print();
    }
  }

class conthpffreq extends CONTROL {
  HPF @ fl;
  HPF @ fr;
  Gain @ ginl;
  Gain @ goutl;
  Gain @ ginr;
  Gain @ goutr;
  params @ ps;

  0 => int active;

  0 =>  update_on_reg ;

  fun void set(float in) {
    if ( ! active  ){
      1 => active;
      ginl =< goutl;
      ginl => fl => goutl;
      ginr =< goutr;
      ginr => fr => goutr;
    }
      float f;
      Std.mtof(in*1.1) => f;
      if (f>19999) {
        <<<"control_freq TOO HIGH:", f>>>;
        19999 => f;
      }
      else if (f< 10) {
        <<<"control_freq TOO LOW:", f>>>;
        10 => f;
      }
      f => fl.freq => fr.freq;
      <<<"control_freq ", fr.freq()>>>; 
      f => ps.hpffreq;
      ps.print();
  }
    
}

class conthpfq extends CONTROL {
  HPF @ fl;
  HPF @ fr;
  params @ ps;
  0 => update_on_reg ;
  
  fun void set (float in) {
    1. + in/16. => fl.Q => fr.Q;

    <<<"control_Q ", fr.Q()>>>; 
    fr.Q() @=> ps.hpfq;
    ps.print();
  }
}

class contbrffreq extends CONTROL {
  BRF @ fl;
  BRF @ fr;
  Gain @ ginl;
  Gain @ goutl;
  Gain @ ginr;
  Gain @ goutr;
  params @ ps;
  int filter_index;

  0 => int active;

  0 =>  update_on_reg ;

  fun void set(float in) {
    if ( ! active  ){
      1 => active;
      ginl =< goutl;
      ginl => fl => goutl;
      ginr =< goutr;
      ginr => fr => goutr;
    }
      float f;
      Std.mtof(in*1.1) => f;
      if (f>19999) {
        <<<"control_freq TOO HIGH:", f>>>;
        19999 => f;
      }
      else if (f< 10) {
        <<<"control_freq TOO LOW:", f>>>;
        10 => f;
      }
      f => fl.freq => fr.freq;
      <<<"control_freq ", fr.freq()>>>; 
      f => ps.brffreq[filter_index];
      ps.print();
  }
    
}

class contbrfq extends CONTROL {
  BRF @ fl;
  BRF @ fr;
  params @ ps;
  int filter_index;
  0 => update_on_reg ;
  
  fun void set (float in) {
    1. + in/12. => fl.Q => fr.Q;

    <<<"control_Q ", fr.Q()>>>; 
    fr.Q() @=> ps.brfq[filter_index];
    ps.print();
  }
}

class contbpffreq extends CONTROL {
  BPF @ fl;
  BPF @ fr;
  Gain @ ginl;
  Gain @ goutl;
  Gain @ ginr;
  Gain @ goutr;
  params @ ps;
  int filter_index;

  0 => int active;

  0 =>  update_on_reg ;

  fun void set(float in) {
    if ( ! active  ){
      1 => active;
      ginl => fl => goutl;
      ginr => fr => goutr;
    }
      float f;
      Std.mtof(in*1.1) => f;
      if (f>19999) {
        <<<"control_freq TOO HIGH:", f>>>;
        19999 => f;
      }
      else if (f< 10) {
        <<<"control_freq TOO LOW:", f>>>;
        10 => f;
      }
      f => fl.freq => fr.freq;
      <<<"control_freq ", fr.freq()>>>; 
      f => ps.bpffreq[filter_index];
      ps.print();
  }
    
}

class contbpfq extends CONTROL {
  BPF @ fl;
  BPF @ fr;
  params @ ps;
  int filter_index;
  0 => update_on_reg ;
  
  fun void set (float in) {
    1. + in/6. => fl.Q => fr.Q;

    <<<"control_Q ", fr.Q()>>>; 
    fr.Q() @=> ps.bpfq[filter_index];
    ps.print();
  }
}

class contbpfg extends CONTROL {
  BPF @ fl;
  BPF @ fr;
  params @ ps;
  int filter_index;
  0 => update_on_reg ;
  fun void set (float in) {
    in/16. => fl.gain => fr.gain;

    <<<"control_Gain ", fr.gain()>>>; 
    fr.gain() @=> ps.bpfg[filter_index];
    ps.print();
  }

}

class contoutg extends CONTROL {
  Gain @ gl;
  Gain @ gr;
  4. => float factor;
  params @ ps;


  0 => update_on_reg ;

  fun void set (float in) {
    in  * factor  / 127. => gl.gain => gr.gain;

    <<<"output gain ", gl.gain()>>>; 
    gl.gain() => ps.outgain; 
    ps.print();
  }

}

public class STEQ extends ST {

  Gain ginl => Gain ginhpfl => Gain gouthpfl => Gain ginlpfl => Gain goutlpfl => Gain ginbrf1l => Gain goutbrf1l => Gain ginbrf2l => Gain goutbrf2l  => Gain ginbpf1l => Gain gbpbpf1l => Gain goutbpf1l=>   Gain ginbpf2l => Gain gbpbpf2l => Gain goutbpf2l=> outl;
  Gain ginr => Gain ginhpfr => Gain gouthpfr => Gain ginlpfr => Gain goutlpfr => Gain ginbrf1r => Gain goutbrf1r => Gain ginbrf2r => Gain goutbrf2r   => Gain ginbpf1r => Gain gbpbpf1r => Gain goutbpf1r=>  Gain ginbpf2r => Gain gbpbpf2r => Gain goutbpf2r=> outr;


  params p;

  LPF lpfl; 1 => lpfl.Q;
  LPF lpfr; 1 => lpfr.Q;

  contlpffreq ctflpf;
  lpfl @=> ctflpf.fl;
  lpfr @=> ctflpf.fr;
  ginlpfl @=> ctflpf.ginl;
  goutlpfl @=> ctflpf.goutl;
  ginlpfr @=> ctflpf.ginr;
  goutlpfr @=> ctflpf.goutr;
  p @=> ctflpf.ps;

  contlpfq ctlpfq;
  lpfl @=> ctlpfq.fl;
  lpfr @=> ctlpfq.fr;
  p @=> ctlpfq.ps;

  HPF hpfl; 1 => hpfl.Q;
  HPF hpfr; 1 => hpfr.Q;

  conthpffreq ctfhpf;
  hpfl @=> ctfhpf.fl;
  hpfr @=> ctfhpf.fr;
  ginhpfl @=> ctfhpf.ginl;
  gouthpfl @=> ctfhpf.goutl;
  ginhpfr @=> ctfhpf.ginr;
  gouthpfr @=> ctfhpf.goutr;
  p @=> ctfhpf.ps;

  conthpfq cthpfq;
  hpfl @=> cthpfq.fl;
  hpfr @=> cthpfq.fr;
  p @=> cthpfq.ps;

  BRF brf1l; 1 => brf1l.Q;
  BRF brf1r; 1 => brf1r.Q;

  contbrffreq ctfbrf1;
  brf1l @=> ctfbrf1.fl;
  brf1r @=> ctfbrf1.fr;
  ginbrf1l @=> ctfbrf1.ginl;
  goutbrf1l @=> ctfbrf1.goutl;
  ginbrf1r @=> ctfbrf1.ginr;
  goutbrf1r @=> ctfbrf1.goutr;
  p @=> ctfbrf1.ps;
  0 => ctfbrf1.filter_index;

  contbrfq ctbrf1q;
  brf1l @=> ctbrf1q.fl;
  brf1r @=> ctbrf1q.fr;
  p @=> ctbrf1q.ps;
  0 => ctbrf1q.filter_index;

  BRF brf2l; 1 => brf2l.Q;
  BRF brf2r; 1 => brf2r.Q;

  contbrffreq ctfbrf2;
  brf2l @=> ctfbrf2.fl;
  brf2r @=> ctfbrf2.fr;
  ginbrf2l @=> ctfbrf2.ginl;
  goutbrf2l @=> ctfbrf2.goutl;
  ginbrf2r @=> ctfbrf2.ginr;
  goutbrf2r @=> ctfbrf2.goutr;
  p @=> ctfbrf2.ps;
  1 => ctfbrf2.filter_index;

  contbrfq ctbrf2q;
  brf2l @=> ctbrf2q.fl;
  brf2r @=> ctbrf2q.fr;
  p @=> ctbrf2q.ps;
  1 => ctbrf2q.filter_index;

  BPF bpf1l; 1 => bpf1l.Q; 0. => bpf1l.gain;
  BPF bpf1r; 1 => bpf1r.Q; 0. => bpf1r.gain;

  contbpffreq ctfbpf1;
  bpf1l @=> ctfbpf1.fl;
  bpf1r @=> ctfbpf1.fr;
  ginbpf1l @=> ctfbpf1.ginl;
  goutbpf1l @=> ctfbpf1.goutl;
  ginbpf1r @=> ctfbpf1.ginr;
  goutbpf1r @=> ctfbpf1.goutr;
  p @=> ctfbpf1.ps;
  0 => ctfbpf1.filter_index;

  contbpfq ctbpf1q;
  bpf1l @=> ctbpf1q.fl;
  bpf1r @=> ctbpf1q.fr;
  p @=> ctbpf1q.ps;
  0 => ctbpf1q.filter_index;

  contbpfg ctbpf1g;
  bpf1l @=> ctbpf1g.fl;
  bpf1r @=> ctbpf1g.fr;
  p @=> ctbpf1g.ps;
  0 => ctbpf1g.filter_index;

  BPF bpf2l; 1 => bpf2l.Q; 0. => bpf2l.gain;
  BPF bpf2r; 1 => bpf2r.Q; 0. => bpf2r.gain;

  contbpffreq ctfbpf2;
  bpf2l @=> ctfbpf2.fl;
  bpf2r @=> ctfbpf2.fr;
  ginbpf2l @=> ctfbpf2.ginl;
  goutbpf2l @=> ctfbpf2.goutl;
  ginbpf2r @=> ctfbpf2.ginr;
  goutbpf2r @=> ctfbpf2.goutr;
  p @=> ctfbpf2.ps;
  1 => ctfbpf2.filter_index;

  contbpfq ctbpf2q;
  bpf2l @=> ctbpf2q.fl;
  bpf2r @=> ctbpf2q.fr;
  p @=> ctbpf2q.ps;
  1 => ctbpf2q.filter_index;

  contbpfg ctbpf2g;
  bpf2l @=> ctbpf2g.fl;
  bpf2r @=> ctbpf2g.fr;
  p @=> ctbpf2g.ps;
  1 => ctbpf2g.filter_index;

  contoutg ctoutg;
  outl @=> ctoutg.gl;
  outr @=> ctoutg.gr;
  p @=> ctoutg.ps;


  fun void connect(ST @ tone, CONTROLER chpff, CONTROLER chpfq, CONTROLER clpff, CONTROLER clpfq, CONTROLER cbrf1f, CONTROLER cbrf1q, CONTROLER cbrf2f, CONTROLER cbrf2q,
      CONTROLER cbpf1f, CONTROLER cbpf1q, CONTROLER cbpf1g,           CONTROLER cbpf2f, CONTROLER cbpf2q, CONTROLER cbpf2g, CONTROLER coutg ) {
    tone.left() => ginl;
    tone.right() => ginr;

    clpff.reg(ctflpf);
    clpfq.reg(ctlpfq);

    chpff.reg(ctfhpf);
    chpfq.reg(cthpfq);

    cbrf1f.reg(ctfbrf1);
    cbrf1q.reg(ctbrf1q);
    cbrf2f.reg(ctfbrf2);
    cbrf2q.reg(ctbrf2q);

    cbpf1f.reg(ctfbpf1);
    cbpf1q.reg(ctbpf1q);
    cbpf1g.reg(ctbpf1g);
    cbpf2f.reg(ctfbpf2);
    cbpf2q.reg(ctbpf2q);
    cbpf2g.reg(ctbpf2g);

    coutg.reg(ctoutg);
  }


  fun void static_connect(ST @ tone, float hpff /* HPF freq */, float hpfq /* HPF Q */, float lpff /* LPF freq */, float lpfq /* LPF Q */
      , float brf1f /* BRF1 freq */, float brf1q /* BRF1 Q */, float brf2f /* BRF2 freq */, float brf2q /* BRF2 Q */
      , float bpf1f  /* BPF1 freq */, float bpf1q /* BPF1 Q */, float bpf1g /* BPF1 Gain */
      , float bpf2f /* BPF2 freq */, float bpf2q /* BPF2 Q */, float bpf2g  /* BPF2 Gain */
      , float outg /* Output Gain */
      ){
    tone.left() => ginl;
    tone.right() => ginr;

    if ( hpff != 0.  ){
      ginhpfl =< gouthpfl;    ginhpfl => hpfl => gouthpfl; 
      ginhpfr =< gouthpfr;    ginhpfr => hpfr => gouthpfr; 
      hpff => hpfl.freq => hpfr.freq;
      hpfq => hpfl.Q => hpfr.Q;
    }

    if ( lpff != 20000.  ){
      ginlpfl =< goutlpfl;    ginlpfl => lpfl => goutlpfl; 
      ginlpfr =< goutlpfr;    ginlpfr => lpfr => goutlpfr; 
      lpff => lpfl.freq => lpfr.freq;
      lpfq => lpfl.Q => lpfr.Q;
    }

    if ( brf1f != 0.  ){
      ginbrf1l =< goutbrf1l;    ginbrf1l => brf1l => goutbrf1l; 
      ginbrf1r =< goutbrf1r;    ginbrf1r => brf1r => goutbrf1r; 
      brf1f => brf1l.freq => brf1r.freq;
      brf1q => brf1l.Q => brf1r.Q;
    }

    if ( brf2f != 0.  ){
      ginbrf2l =< goutbrf2l;    ginbrf2l => brf2l => goutbrf2l; 
      ginbrf2r =< goutbrf2r;    ginbrf2r => brf2r => goutbrf2r; 
      brf2f => brf2l.freq => brf2r.freq;
      brf2q => brf2l.Q => brf2r.Q;
    }

    if ( bpf1f != 0. ){
      ginbpf1l => bpf1l => goutbpf1l;
      ginbpf1r => bpf1r => goutbpf1r;
      bpf1f => bpf1l.freq => bpf1r.freq;
      bpf1q => bpf1l.Q    => bpf1r.Q;
      bpf1g => bpf1l.gain => bpf1r.gain;
    }

    if ( bpf2f != 0. ){
      ginbpf2l => bpf2l => goutbpf2l;
      ginbpf2r => bpf2r => goutbpf2r;
      bpf2f => bpf2l.freq => bpf2r.freq;
      bpf2q => bpf2l.Q    => bpf2r.Q;
      bpf2g => bpf2l.gain => bpf2r.gain;
    }

    if ( outg !=1.  ){
      outg => outl.gain => outr.gain;
    }
  }
}
