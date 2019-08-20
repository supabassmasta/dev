class stpassthru extends SYNT{

     ADSR al;
     ADSR ar;
     al.set(3::ms, 0::ms, 1., 3::ms);
     ar.set(3::ms, 0::ms, 1., 3::ms);

    inlet =>  blackhole; 

        fun void on()  { al.keyOn(); ar.keyOn(); }  fun void off() { al.keyOff(); ar.keyOff();}  fun void new_note(int idx)  { } 0 => own_adsr;
} 

class STCUTTER extends ST {

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


TONE t;
t.reg(CHORUSA0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.reg(CHORUSA0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.reg(CHORUSA0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c :4  
1|5|8
" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2 * data.tick, 10::ms, 1., 4*data.tick);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(2 * data.tick, 10::ms, 1., 4*data.tick);
t.adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[2].set(2 * data.tick, 10::ms, 1., 4*data.tick);
t.adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 3 * 100 /* f_base */ , 4 * 100  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STCUTTER stcutter;
"11 *8 1_1_1_1_ _1__ 1__1 _1__" => stcutter.t.seq;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last;

while(1) {
       100::ms => now;
}
 
