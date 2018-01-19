SEQ s;  
data.tick * 16 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); //
SET_WAV.TRANCE_VARIOUS(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); //
"" => s.wav["a"]; 
"" => s.wav["b"]; 
 

 Break.stbreak_set(0) @=> s.action["a"]; 
 Break.stbreak_release(0) @=> s.action["b"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//d|b___ ___C|a _C_C CCCC
"
____ ____
____ ___
*8 *2
____
____
BBBB
AAAA
" => s.seq;
//b___ ____ ___a CCCC
.7 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

s.print();
//STDUCKMASTER duckm;
//duckm.connect(last $ ST, 9. /* In Gain */, .14 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

STDIGIT dig;
dig.connect(last $ ST , 8::samp /* sub sample period */ , .01 /* quantization */);      dig $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 2 / 3 , .7);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
