TONE t;
t.reg(HORROR s1);  //data.tick * 7 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();t.aeo(); t.phr();t.loc();
"0" => t.seq;
// t.element_sync(); t.no_sync(); t.full_sync();     //t.print();
t.go(); 

while(1) {
       100::ms => now;
}

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"" => s.seq;
// s.element_sync(); s.no_sync(); s.full_sync();     //s.print();
// s.mono() => dac; s.left() => dac.left; s.right() => dac.right;
s.go();
 
