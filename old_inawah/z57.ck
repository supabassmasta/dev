TONE t;
t.reg(SUPERSAW0 s1);
t.reg(SUPERSAW0 s2);
t.reg(SUPERSAW0 s3);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // 
t.dor(); // t.mix();//
//t.aeo();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
____
__3|0_
" => t.seq;
.13 * data.master_gain => t.gain;
1.4 => s1.outlet.gain;
0.6 => s2.outlet.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(1000::ms, 2000::ms, .7 , 2000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(2000::ms, 2000::ms, .7 , 2000::ms);
t.adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave


t.go();   t $ ST @=> ST @ last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 
//STLPF lpf;
//lpf.connect(last $ ST , 510/* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

//STLPFC lpfc;
//lpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lpfc $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 10 /* Q */, 600 /* f_base */ , 70 * 100  /* f_var */, 7::second / (19 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(6 * 100 /* Base */, 20 * 100 /* Variable */, 4. /* Q */);
stsynclpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, 0.8 /* Relative Sustain dur */, .4 /* Relative release */);
stsynclpf.connect(t $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 



STREV1 rev; // DUCKED
rev.connect(last $ ST, .1 /* mix */);      rev $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
