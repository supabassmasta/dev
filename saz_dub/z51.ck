TONE t;
t.reg(SERUM0 s0); s0.config(13,2);
//t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.aeo();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c}c  4__1 !1_4_ 51__ 4___ 
 4__1 !1_4_ 3!5__ 1___

" => t.seq;
.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynckgx0; KG_XFACTORY stsynckgx0_fact;
stsynckgx0.freq(100 /* Base */, 11 * 100 /* Variable */, 3. /* Q */);
stsynckgx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.5 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynckgx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynckgx0.connect(last $ ST ,  stsynckgx0_fact, t.note_info_tx_o , 5 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynckgx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynckgx0.nio.padsr; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 


//STGVERB stgverb;
//stgverb.connect(last $ ST, .1 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
