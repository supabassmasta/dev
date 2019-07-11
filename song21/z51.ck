  class control_step extends CONTROL {
    step @ st;
    float min;
    float max;
     
    1 => update_on_reg ;
    
    fun void set (float in) {
      (in / 127.) * (max - min) + min => st.next;
      <<<"Step next:", st.next()>>>;
    }
  }

  class STEPC {
    step out;

    control_step cs;
    out @=> cs.st;

    fun void init(CONTROLER cont, float min, float max) {
      min => cs.min;
      max => cs.max;
      cont.reg(cs);

    }

  }



STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 100 /* min */, 1000 /* max */);
stepc.out =>         SinOsc s => dac;
//stepc.out =>       LPF lpf  => dac;
//stepc.out =>       LPF lpf =>  SinOsc s => dac;
//2 => lpf.freq;

.3 => s.gain;


while(1) {
       100::ms => now;
}
 
