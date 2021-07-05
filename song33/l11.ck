TONE t;
t.reg(SYNTADD syntadd);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//

SYNTWAV s0; s0.config(.5 /* G */, 0::ms /* ATTACK */, 1::second /* RELEASE */, 25 /* FILE */, 100::ms /* UPDATE */);
// s0.pos s0.rate s0.lastbuf 
syntadd.add(s0 /* SYNT, to declare outside */, .5 /* Gain */, 1. /* freq gain */); 
//PLOC0 s1;
//syntadd.add(s1 /* SYNT, to declare outside */, .1 /* Gain */, 2. /* freq gain */); 




t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"4_2_ 0//0__ 3_5_ 1//1__" => t.seq;
1.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

//STADSR stadsr;
//stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 0.6 /* Sustain */, 1 * data.tick /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
//stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff(); 

while(1) {
       100::ms => now;
}
 
