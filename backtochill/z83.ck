SEQ s;  //data.tick * 8 => s.max;  // 
SET_WAV.TRIBAL0(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
/*
a_ bc 
__ __ 
af b_ 
_b bc 

a_ bc 
__ cc 
af b_ 
_b cc 
*/
"
_<3a
" => s.seq;
.29  * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
 //// SUBWAV ////
 SEQ s2; SET_WAV.TRIBAL0(s2); s.add_subwav("a", s2.wav["b"]); s.gain_subwav("a", 0, 3.5);
 s.go();     s $ ST @=> ST @ last; 

STLPF lpf;
lpf.connect(last $ ST , 7*1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .3 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
