TONE t;
t.reg(SUPERSAW0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 1234567876543210" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STEQ steq;
steq.static_connect(last $ ST,  10.000000  /* HPF freq */,  1.000000  /* HPF Q */,  447.691065  /* LPF freq */,  4.437500  /* LPF Q */
      ,  1405.005160  /* BRF1 freq */,  1.000000  /* BRF1 Q */,  2652.296559  /* BRF2 freq */,  6.000000  /* BRF2 Q */
      ,  0.000000  /* BPF1 freq */,  1.000000  /* BPF1 Q */,  0.000000  /* BPF1 Gain */
      ,  0.000000  /* BPF2 freq */,  1.000000  /* BPF2 Q */,  0.000000   /* BPF2 Gain */
      ,  0.251969  /* Output Gain */ ); steq $ ST @=>  last; 
while(1) {
       100::ms => now;
}
 
