  TONE t;
  t.reg(SERUM3 s0);  //data.tick * 8 => t.max; 
  s0.config(2 /* synt nb */ );
//  STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 0 /* min */, 1 /* max */, 50::ms /* transition_dur */);
//  stepc.out => s0.in; s0.control_update(10::ms); 

   SinOsc sin0 =>  OFFSET ofs0  => s0.in; s0.control_update(1::ms);
   0.5 => ofs0.offset;
   1. => ofs0.gain;
   
   0.01 => sin0.freq;
   0.5 => sin0.gain;


  30::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "*4 }c}c 
  845231 
  " => t.seq;
  .15 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(10::ms, 10::ms, 1., 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 


STGVERB stgverb;
stgverb.connect(last $ ST, .05 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
