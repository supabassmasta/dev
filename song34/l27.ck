    ST stmain; 
    dac.left => stmain.outl;
    dac.right => stmain.outr;

STREC strec;
//strec.connect(stmain $ ST, 8*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); // strec $ ST @=>  last;  
strec.connect(stmain $ ST ); // strec $ ST @=>  last;  
0 => strec.gain;
strec.rec_start(  "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ );

TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2 /* synt nb */ ); 

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}7 *4  12345432" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 9/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .1 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  


8*data.tick => now;
strec.rec_stop(0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ );



while(1) {
       100::ms => now;
}
 



