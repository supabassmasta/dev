SEQ s;  //data.tick * 8 => s.max;  // 
SET_WAV.TRIBAL(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
HW.ledstrip.set_tx('l') @=> s.action["M"];
"
M___ ____ ____ ____ 
M___ ____ ____ ___-2K 
M___ ____ ____ ____ 
M___ ____ ____ __ *2 K-4vK_ 
" => s.seq;
1.7  * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
4 * data.tick => s.the_end.fixed_end_dur;
s.no_sync();
s.go();     s $ ST @=> ST @ last; 

STREV1 rev;
rev.connect(last $ ST, .3 /* mix */);     rev  $ ST @=>  last; 

//MASTER_SEQ3.update_ref_times(now + 10::ms, data.tick * 16 * 128 );

while(1) {
       100::ms => now;
}
 
