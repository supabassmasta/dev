TONE t;
t.reg(CELLO1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.reg(CELLO1 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.reg(CELLO1 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c :4  
_ 1|5|8 _ }c _ B|1|5 _
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

//STFILTERMOD fmod;
//fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 3 * 100 /* f_base */ , 4 * 100  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STLPF lpf;
lpf.connect(last $ ST , 6 * 100 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
