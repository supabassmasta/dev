TONE t;
t.reg(SERUM0 s0); s0.config(9, 1); 
t.reg(SERUM0 s1); s1.config(9, 1); 
//t.reg(CELLO0 s1); 
//t.reg(CELLO0 s2); 
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 }c}c  *2_:2 1|3_ #0|2_ 1|5_ #0|3 *2_:2 " => t.seq;
.1 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 600::ms, .9, 1400::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(2::ms, 600::ms, .9, 1400::ms);
t.adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  13::ms /* dur base */, 1::ms /* dur range */, 1 /* freq */); 

//STSYNCLPF stsynclpf;
//stsynclpf.freq(100 /* Base */, 21 * 100 /* Variable */, 1.2 /* Q */);
//stsynclpf.adsr_set(.4 /* Relative Attack */, .2/* Relative Decay */, 0.7 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
//stsynclpf.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(100 /* Base */, 21 * 100 /* Variable */, 1.2 /* Q */);
stsynclpfx0.adsr_set(.4 /* Relative Attack */, .2/* Relative Decay */, 0.7 /* Sustain */, .2 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

///SYNC sy;
//sy.sync(4 * data.tick);

//STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
//stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 3.0 /* Q */, 13 * 100 /* freq base */, 2 * 100 /* freq var */, data.tick * 1 / 4 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  
//
STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 8 * 10. /* room size */, 4::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
