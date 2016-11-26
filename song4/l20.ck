SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);
 SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"+++++k|n" => s.seq;
// s.element_sync(); //s.no_sync(); //s.full_sync();     //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

STDUCKMASTER duckm;
duckm.connect(s);


while(1) {
	     100::ms => now;
}
 
