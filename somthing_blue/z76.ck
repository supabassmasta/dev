SEQ s;  //data.tick * 8 => s.max;  //
SET_WAV.TRANCE(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
SEQ s2;  //data.tick * 8 => s.max;  //
SET_WAV.DUB(s2);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to _current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  

"../_SAMPLES/NOIIZ/Rattles_54_76_SP.wav" => s.wav["r"]; 
s2.wav["a"] => s.wav["a"]; 
"
*8
____ ____ ____ ____ 
____ ____ ____ ____ 
____ ____ a___ ____ 
____ ____ ____ ____ 

" => s.seq;
//s.gain("c", .5); // for single wav 
.4 * data.master_gain => s.gain; //
s.gain("k", 0.9); // for single wav 
s.gain("r", 0.2); // for single wav 
//s.gain("h", 1.7); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 8 , .6);  ech $ ST @=>  last; 

while(1) {
	     100::ms => now;
}
 
