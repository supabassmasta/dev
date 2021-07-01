TONE t;
SYNTWAV s0;
t.reg( s0); 
s0.config(.5 /* G */, 1::second /* ATTACK */, 2::second /* RELEASE */, 21 /* FILE */, 100::ms /* UPDATE */); 
SYNTWAV s1;
t.reg( s1); 
s1.config(.5 /* G */, 1::second /* ATTACK */, 2::second /* RELEASE */, 1 /* FILE */, 100::ms /* UPDATE */); 

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
/*

*/
":2 
1_3_8_5_4_
1_c_3_6_2_
" => t.seq;

.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //
t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .3);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
