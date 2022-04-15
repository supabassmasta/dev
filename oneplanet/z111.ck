TONE t;
t.reg(KIK kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
kik.config(0.1 /* init Sin Phase */, 13 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (240.0, 3::ms);
kik.addFreqPoint (85.0, 50::ms);
kik.addFreqPoint (36.0, 13 * 10::ms);

kik.addGainPoint (0.4, 13::ms);
kik.addGainPoint (0.3, 25::ms);
kik.addGainPoint (0.8, 10::ms);
kik.addGainPoint (0.7, 13 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"k" => t.seq;
.27 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
//t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


//STDUCKMASTER duckm;
//duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 4::ms /* Release */ );      duckm $ ST @=>  last; 

STOVERDRIVE stod;
stod.connect(last $ ST, 1.7 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 
.6 => stod.gain;




while(1) {
       100::ms => now;
}
 


