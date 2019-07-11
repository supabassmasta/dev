  class control_step extends CONTROL {
    Envelope @ st;
    float min;
    float max;
     
    1 => update_on_reg ;
    
    fun void set (float in) {
      (in / 127.) * (max - min) + min => st.target;
      <<<"Step next:", st.target()>>>;
    }
  }

  class STEPC {
    step one => Envelope out;
    1. => one.next;

    control_step cs;
    out @=> cs.st;

    fun void init(CONTROLER cont, float min, float max, dur transition_dur) {
      min => cs.min;
      max => cs.max;
      cont.reg(cs);
      transition_dur => out.duration;
    }

  }



STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 100 /* min */, 3000 /* max */, 50::ms /* transition_dur */);
stepc.out =>         SinOsc s => dac;
//stepc.out =>       LPF lpf  => dac;
//stepc.out =>       LPF lpf =>  SinOsc s => dac;
//2 => lpf.freq;

.3 => s.gain;


while(1) {
       100::ms => now;
}
 
