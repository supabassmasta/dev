class params {
  float lpffreq;
  float lpfq;

  fun void print (){
    <<<"LPF FREQ, ", lpffreq>>>;
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
    Std.mtof(in) => f;
    if (f>19000) {
      <<<"control_freq TOO HIGH:", f>>>;
    }
    else if (f< 10) {
      <<<"control_freq TOO LOW:", f>>>;
      10 => fl.freq => fr.freq;
    }
    else {
      f => fl.freq => fr.freq;
      <<<"control_freq ", fr.freq()>>>; 
      f => ps.lpffreq;
      ps.print();
    }
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
    }
  }


class STEQ extends ST {

  Gain ginl => Gain ginhpfl => Gain gouthpfl => Gain ginlpfl => Gain goutlpfl => outl;
  Gain ginr => Gain ginhpfr => Gain gouthpfr => Gain ginlpfr => Gain goutlpfr => outr;


  params p;

  LPF lpfl;
  LPF lpfr;

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

  fun void connect(ST @ tone, CONTROLER clpff, CONTROLER clpfq) {
    tone.left() => ginl;
    tone.right() => ginr;

    clpff.reg(ctflpf);
    clpfq.reg(ctlpfq);

  }

}

ST st;
Noise n => st.mono_in; st @=> ST @ last;
.01 => n.gain;

STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 4 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STEQ steq;
steq.connect(last, HW.lpd8.potar[1][1] /* LPF freq */, HW.lpd8.potar[1][2] /* LPF Q */);


while(1) {
       100::ms => now;
}
 

