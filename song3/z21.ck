SEQ s;  //data.tick * 8 => s.max;  //$
SET_WAV2.__SAMPLES(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4 -----D_++D-----D__D+D++D" => s.seq;
 s.element_sync(); //
 //s.no_sync(); s.full_sync();     //s.print();
// s.mono() => dac; s.left() => dac.left; s.right() => dac.right;
//.5 => s.gain;
s.go(); 

while(1) {
	     100::ms => now;
}

