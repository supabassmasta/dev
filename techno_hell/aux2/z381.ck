22 => int n;
0 => int m;

TONE t;
t.reg(SERUM0 s0); s0.config(n,m);
t.reg(SERUM0 s1); s1.config(n,m); .7 => s1.outlet.gain;
t.reg(SERUM0 s2); s2.config(n,m); .5 => s1.outlet.gain;
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 }c !1|3|5" => t.seq;
.08 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[1].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[2].set(2000::ms, 1000::ms, .8, 4000::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  9::ms /* dur base */, 3::ms /* dur range */, 1::second / ( 32 * data.tick ) /* freq */); 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 26 * 100 /* Variable */, 1. /* Q */);
stsynclpf.adsr_set(1.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 100 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .4 /* mix */, 4 * 10. /* room size */, 5::second /* rev time */, 0.3 /* early */ , 0.4 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 

