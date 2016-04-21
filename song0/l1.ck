SEQ s;  //data.tick * 8 => s.max;  
SET_WAV.VOLCA(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4 ++k _ -----h _ s ___" => s.seq;
"k_kk sh_k" => s.seq;
"k_h_ sh_k" => s.seq;
"k_h_ hs_h" => s.seq;
 s.element_sync(); // s.no_sync(); s.full_sync();     //s.print();
// s.mono() => dac; s.left() => dac.left; s.right() => dac.right;
s.go(); 
while(1) {
       100::ms => now;
}
 
