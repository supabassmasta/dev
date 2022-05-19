TONE t;//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SYNTWAV s0);  
t.reg(SYNTWAV s1);  
t.reg(SYNTWAV s2);  
25 => int k;
s0.config(.5 /* G */, 1::second /* ATTACK */, 5::second /* RELEASE */, k /* FILE */, 100::ms /* UPDATE */);
s1.config(.5 /* G */, 1::second /* ATTACK */, 5::second /* RELEASE */, k /* FILE */, 100::ms /* UPDATE */);
s2.config(.2 /* G */, 1::second /* ATTACK */, 5::second /* RELEASE */, k /* FILE */, 100::ms /* UPDATE */);
// s0.pos s0.rate s0.lastbuf 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 !1|3|5_8|5|3_0|1|3_3|#4|7_" => t.seq;
1.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


//STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
//stsynclpfx0.freq(100 /* Base */, 90 * 100 /* Variable */, 2. /* Q */);
//stsynclpfx0.adsr_set(.3 /* Relative Attack */, .1/* Relative Decay */, 1.0 /* Sustain */, .3 /* Relative Sustain dur */, 0.9 /* Relative release */);
//stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .4 /* delay line gain */,  6::ms /* dur base */, 2::ms /* dur range */, 3/4 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .4 /* delay line gain */,  6::ms /* dur base */, 3::ms /* dur range */, 2/4 /* freq */); 


STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 3.0 /* Q */, 8 * 100 /* freq base */, 28 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STGVERB stgverb;
stgverb.connect(last $ ST, .15 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
