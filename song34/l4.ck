class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 
TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; 
30::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//s0.config(13 /* synt nb */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c 6543216543651234345 " => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 



STCONVREV stconvrev;
stconvrev.connect(last $ ST , 2/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .1 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
