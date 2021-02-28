     TONE t;
     t.reg(SYNTWAV s0); s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 0 /* FILE */, 100::ms /* UPDATE */); 
     t.reg(SYNTWAV s1); s1.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 1 /* FILE */, 100::ms /* UPDATE */); 
     t.reg(SYNTWAV s2); s2.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 2 /* FILE */, 100::ms /* UPDATE */); 
     t.reg(SYNTWAV s3); s3.config(.06 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 4 /* FILE */, 100::ms /* UPDATE */); 
     t.reg(SYNTWAV s4); s4.config(.4 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 4 /* FILE */, 100::ms /* UPDATE */); 
     t.reg(SYNTWAV s5); s5.config(.4 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 4 /* FILE */, 100::ms /* UPDATE */); 
     
     
     
     t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
     // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
     ":2 2|4|1|8 1|3|5|8_3|5|7 2|4|1|4 0|2|4|0 1|3|5"=> t.seq;
     .9 * data.master_gain => t.gain;
     //t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
     // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
     //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
     //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
     t.go();   t $ ST @=> ST @ last; 
     




//      STSAMPLER stsampler;
//      stsampler.connect(last $ ST, 32*data.tick, "./" /* path for wav */,  "sample" /* wav name, /!\ NO EXTENSION */, 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); stsampler $ ST @=>  last;  
//      



//     LONG_WAV l;
//     "sample1.wav" => l.read;
//     1.0 * data.master_gain => l.buf.gain;
//     0 => l.update_ref_time;
//     l.AttackRelease(1000::ms, 0::ms);
//     l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STGVERB stgverb;
stgverb.connect(last $ ST, .05 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
