SEQ s;  //data.tick * 8 => s.max;  // 
//SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
//SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); //
//SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // 
SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4 
____ ____ s___ ___}6t
____ __s_ ____ ____
___t _t__ s___ ____
___t __s_ ____ ____
" => s.seq;
.18 * data.master_gain => s.gain; // 
s.gain("t", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STLPF lpf;
lpf.connect(last $ ST , 30 * 100 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .3 /* mix */, 22 * 10. /* room size */, 2000::ms /* rev time */, 0.3 /* early */ , 0.4 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
