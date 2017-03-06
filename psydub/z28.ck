SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// 
SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"--k" => s.seq;
// s.element_sync(); //s.no_sync(); 
s.full_sync();     //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
1.6 => s.gain;
s.go(); 

STDUCKMASTER duckm;
duckm.connect(s $ ST, 9. /* In Gain */, .03 /* Tresh */, .6 /* Slope */, 25::ms /* Attack */, 28::ms /* Release */ ); 
//duckm.right() => blackhole;
//duckm.left() => blackhole;

while(1) {
	     100::ms => now;
}
 
