public class STFLANGER extends ST{
  1::samp => dur period;

 Gain fbl => outl;

 Gain fbr => outr;

  fun void connect(ST @ tone) {
    tone.left() => fbl;
    tone.right() => fbr;

  }
  
  fun void control(Delay @ d, dur base,  dur range, float freq){
    SinOsc s => blackhole;

    freq => s.freq;

    while(1) {
      base + s.last() * range / 2. => d.delay; 
      period => now;
    }
     
  }


  fun void add_line(int left_right_both /* 0 : left, 1: right 2: both */, float g, dur base, dur range, float freq) {

    new Delay @=> Delay @ d;
    base + range/2. => d.max;
    base => d.delay;
    g => d.gain;

    if ( range != 0::ms  ){
      spork ~ control(d, base, range, freq);
    }

    if ( left_right_both == 0 || left_right_both == 2 ){
      fbl => d => fbl;
    }
    else {
      fbr => d => fbr;
    }

    if ( left_right_both == 2   ){
      add_line(1 /* right */, g, base, range, freq);
    }


  }
}


