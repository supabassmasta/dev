SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);
SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // "test.wav" => s.wav["a"];  
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"k" => s.seq;
.9 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

STDUCKMASTER duckm;
duckm.connect(s $ ST, 9. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ ); 

//duckm.mono() => blackhole;

while(1) {
       100::ms => now;
}


