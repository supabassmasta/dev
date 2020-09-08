TONE t;
t.reg(SERUM0 s0); s0.config(2, 2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); //
t.ion(); // t.mix();//
//t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *4 }c}c 
1__1 __1_ 3__0 _0__
1__1 __1_ 3_*20_ !0 ___:2 0__

" => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ADSRMOD adsrmod;
adsrmod.adsr_set(0.2 /* relative attack dur */, 0.2/* relative decay dur */ , 0.5 /* sustain */, - 0.2 /* relative sustain pos */, .1 /* relative sustain dur */);
adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 
//
STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .4 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 38 /* freq */); 

STGVERB stgverb;
stgverb.connect(last $ ST, .0001 /* mix */, 7 * 10. /* room size */, 2::second /* rev time */, 0.2 /* early */ , 0.5 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
