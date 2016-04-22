SEQ s;  //data.tick * 8 => s.max;  
SET_WAV.DUBSTEP(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"s" => s.seq;
// s.element_sync(); s.no_sync(); s.full_sync();     //s.print();
 s.mono() => dac; //s.left() => dac.left; s.right() => dac.right;
s.mono() => Gain r => global_mixer.rev0;
.7 => r.gain;
s.go(); 

while(1) {
       100::ms => now;
}
 
