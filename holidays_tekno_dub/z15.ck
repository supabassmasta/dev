
TONE t;
t.reg(KIK kik );  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
kik.config(0.1 /* init Sin Phase */, 61 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (209.0, 2::ms);
kik.addFreqPoint (100.0, 20::ms);
kik.addFreqPoint (35.0, 11 * 10::ms);

kik.addGainPoint (0.6, 2::ms);
kik.addGainPoint (0.3, 10::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 110::ms);
kik.addGainPoint (0.0, 15::ms); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2 
1_1_1_1_ 111_1_1_
1_1_1_1_ 1_1_1_1*2_1:2
1_1_1_1_ 111_1_1_
1_1_1_1_ 1_1_1_*211_1
" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .02 /* mix */, 1 * 10. /* room size */, 27 * 10::ms /* rev time */, 0.2 /* early */ , 0.4 /* tail */ ); stgverb $ ST @=>  last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 25* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
