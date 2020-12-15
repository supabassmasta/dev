public class STECHOV extends ST{
  dur rate;

  Gain fbl => outl;
  fbl => Delay dl => fbl;

  Gain fbr => outr;
  fbr => Delay dr => fbr;

  .5 =>  dl.gain => dr.gain;


  Gain del => blackhole;
  Gain g  => blackhole;

  fun void f1 (){ 
    while(1) {
      del.last() * 1::samp => dl.delay => dr.delay;
      g.last() => dl.gain => dr.gain;

      rate => now;
    }
  } 
  spork ~ f1 ();

  fun void control(dur delsart, dur delstop, dur del_trans_dur, float gainstart, float gainstop, dur gain_trans_dur) {  
    Step stp0 =>  Envelope e0 =>  del;
    delsart / 1::samp => e0.value;
    delstop / 1::samp => e0.target;
    del_trans_dur => e0.duration ;// => now;

    1.0 => stp0.next;

    stp0 => Envelope e1 => g;  
    gainstart => e1.value;
    gainstop => e1.target;
    gain_trans_dur => e1.duration; 
    
    // keep Env connected after transitions
    while(1) {
           100::ms => now;
    }
     
  }


  fun void connect(ST @ tone, dur dmax, dur r) {
    tone.left() => fbl;
    tone.right() => fbr;

    dmax => dl.max => dl.delay => dr.max => dr.delay;

    r => rate;

  }

}


