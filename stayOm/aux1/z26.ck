TONE t;
0 => int n;
1 => int k;

t.reg(SERUM0 s0); s0.config(n, k);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM0 s1); s1.config(n, k);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM0 s2); s2.config(n, k);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c }c _A|1|3_A|1|3 _A|1|3_A|1|3   _1|3|5_1|3|5 _1|3|5_1|3|5" => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 4 * 10::ms, .00002, 400::ms);
t.adsr[0].setCurves(1.0, 2.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(2::ms, 4 * 10::ms, .00002, 400::ms);
t.adsr[1].setCurves(1.0, 2.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[2].set(2::ms, 4 * 10::ms, .00002, 400::ms);
t.adsr[2].setCurves(1.0, 2.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STDELAY stdelay;
stdelay.connect(last $ ST , data.tick * 1. / 4. /* static delay */ );       stdelay $ ST @=>  last;  

STGAIN stgain0;
stgain0.connect(last $ ST , 0.5 /* static gain */  );       stgain0 $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(t $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 1200 /* f_base */ , 4800  /* f_var */, 1::second / (16 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 8 * 10. /* room size */, 2::second /* rev time */, 0.1 /* early */ , 0.4 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
