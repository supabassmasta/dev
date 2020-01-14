class stpassthru extends SYNT{

     ADSR al;
     ADSR ar;
     al.set(3::ms, 0::ms, 1., 3::ms);
     ar.set(3::ms, 0::ms, 1., 3::ms);

    inlet =>  blackhole; 

        fun void on()  { al.keyOn(); ar.keyOn(); }  fun void off() { al.keyOff(); ar.keyOff();}  fun void new_note(int idx)  { } 0 => own_adsr;
} 

public class STCUTTER extends ST {

  TONE t;
  t.reg(stpassthru s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  1. => t.gain;
  //t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  //t.go();   t $ ST @=> ST @ last; 

  t.left() => blackhole;
  t.right() => blackhole;

  s0.al => outl;
  s0.ar => outr;

  fun void connect(ST @ tone, dur attack, dur release) {
    tone.left() => s0.al;
    tone.right() => s0.ar;
    s0.al.set(3::ms, 0::ms, 1., 3::ms);
    s0.ar.set(3::ms, 0::ms, 1., 3::ms);
    t.go();
  }
}

