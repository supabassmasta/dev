TONE t;
t.reg(SERUM0 s0); s0.config(22,0);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*3 
!1_1_1_
1_1_1!1
" => t.seq;
1.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(8::ms, 35::ms, .6, 400::ms);
t.adsr[0].setCurves(0.8, 1.2, 1.4); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERMOD fmod;
fmod.connect( last , "BPF" /* "HPF" "BPF" BRF" "ResonZ" */, 1.3 /* Q */, 2 * 100 /* f_base */ , 9 * 100  /* f_var */, 1::second / (13 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

//STFILTERMOD fmod2;
//fmod2.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 400  /* f_var */, 3::second / (2 * data.tick) /* f_mod */);     fmod2  $ ST @=>  last; 

STLPF lpf;
lpf.connect(last $ ST , 3 * 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
