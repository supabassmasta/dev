TONE t;
t.reg(SUPERSAW0 s0);  //data.tick * 8 => t.max; 
60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c 1111 5555 3333 2228 1111 5555 3333  *2 8181 8181 :2 " => string part;
part => t.seq;
1.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 


t.go();   t $ ST @=> ST @ last; 

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 38* 100.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 1.3 /* Q */, 2 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 
AUTO.freq("}c}c}c}c}7" + part) => stfreelpfx0.freq; // CONNECT THIS 


while(1) {
       100::ms => now;
}
 
