TONE t;
t.reg(SERUM0 s0); s0.config(9, 0); //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c  11111111 ____ ____" => t.seq;
.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STEQ steq;
//steq.connect(last $ ST, HW.lpd8.potar[1][1] /* HPF freq */, HW.lpd8.potar[1][2] /* HPF Q */, HW.lpd8.potar[1][3] /* LPF freq */, HW.lpd8.potar[1][4] /* LPF Q */
// , HW.lpd8.potar[1][5] /* BRF1 freq */, HW.lpd8.potar[1][6] /* BRF1 Q */, HW.lpd8.potar[1][7] /* BRF2 freq */, HW.lpd8.potar[1][8] /* BRF2 Q */
//  , HW.lpd8.potar[2][1] /* BPF1 freq */, HW.lpd8.potar[2][2] /* BPF1 Q */, HW.lpd8.potar[2][3] /* BPF1 Gain */
//   , HW.lpd8.potar[2][5] /* BPF2 freq */, HW.lpd8.potar[2][6] /* BPF2 Q */, HW.lpd8.potar[2][7] /* BPF2 Gain */
//    , HW.lpd8.potar[2][8] /* Output Gain */  ); steq $ ST @=>  last; 
steq.static_connect(last $ ST,  48.436623  /* HPF freq */,  8.250000  /* HPF Q */,  2489.015870  /* LPF freq */,  2.562500  /* LPF Q */
      ,  0.000000  /* BRF1 freq */,  1.000000  /* BRF1 Q */,  0.000000  /* BRF2 freq */,  1.000000  /* BRF2 Q */
      ,  0.000000  /* BPF1 freq */,  1.000000  /* BPF1 Q */,  0.000000  /* BPF1 Gain */
      ,  0.000000  /* BPF2 freq */,  1.000000  /* BPF2 Q */,  0.000000   /* BPF2 Gain */
      ,  1.000000  /* Output Gain */ ); steq $ ST @=>  last; 


STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 11 * 10. /* room size */, 2::second /* rev time */, 0.2 /* early */ , 0.5 /* tail */ ); stgverb $ ST @=>  last; 

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
