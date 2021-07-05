TONE t;
t.reg(SYNTADD syntadd );  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
SYNTWAV s0; s0.config(.5 /* G */, 1::ms  /* ATTACK */, 500::ms /* RELEASE */, 20 /* FILE */, 100::ms /* UPDATE */); // s0.pos s0.rate s0.lastbuf 
SYNTWAV s1; s1.config(.5 /* G */, 1::ms  /* ATTACK */, 500::ms /* RELEASE */, 7 /* FILE */, 100::ms /* UPDATE */); // s0.pos s0.rate s0.lastbuf 
SYNTWAV s2; s2.config(.5 /* G */, 1::ms  /* ATTACK */, 500::ms /* RELEASE */, 15 /* FILE */, 100::ms /* UPDATE */); // s0.pos s0.rate s0.lastbuf 
SYNTWAV s3; s3.config(.5 /* G */, 1::ms  /* ATTACK */, 500::ms /* RELEASE */, 48 /* FILE */, 100::ms /* UPDATE */); // s0.pos s0.rate s0.lastbuf 
SYNTWAV s4; s4.config(.5 /* G */, 1::ms  /* ATTACK */, 500::ms /* RELEASE */, 46 /* FILE */, 100::ms /* UPDATE */); // s0.pos s0.rate s0.lastbuf 
SYNTWAV s5; s5.config(.5 /* G */, 1::ms  /* ATTACK */, 500::ms /* RELEASE */, 46 /* FILE */, 100::ms /* UPDATE */); // s0.pos s0.rate s0.lastbuf AA

// syntadd.add(s0 /* SYNT, to declare outside */, .5 /* Gain */, 1. /* freq gain */); 
// syntadd.add(s1 /* SYNT, to declare outside */, .5 /* Gain */, 1. /* freq gain */); 
// syntadd.add(s2 /* SYNT, to declare outside */, .5 /* Gain */, 1. /* freq gain */); 
syntadd.add(s3 /* SYNT, to declare outside */, 1.5 /* Gain */, 0.5 /* freq gain */); 
syntadd.add(s4 /* SYNT, to declare outside */, 1.5 /* Gain */, 1. /* freq gain */); 
syntadd.add(s5 /* SYNT, to declare outside */, 1.5 /* Gain */, 0.5 /* freq gain */); 



t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2  
1___ ____ ____ __3_
1___ ____ ____ ____

" => t.seq;
1.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STPADSR stpadsr;
stpadsr.set(9::ms /* Attack */, 79::ms /* Decay */, 0.5 /* Sustain */, 4 * 100::ms /* Sustain dur of Relative release pos (float)*/,  1000::ms /* release */);
stpadsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stpadsr.connect(last $ ST, t.note_info_tx_o); stpadsr $ ST @=>  last;
//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
// stpadsr.keyOn(); stpadsr.keyOff(); 

STGVERB stgverb;
stgverb.connect(last $ ST, .10 /* mix */, 9 * 10. /* room size */, 3::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
