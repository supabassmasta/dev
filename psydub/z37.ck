SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); 
SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4" => s.seq;
"k_k_ t___" => s.seq;
"k__k t__s" => s.seq;
"k_k_ tk__" => s.seq;
"kskk t_ks" => s.seq;
"k_k_ t___" => s.seq;
"k__k t__s" => s.seq;
"k_k_ tku_" => s.seq;
"kskk|t lmno" => s.seq;
.6 => s.gain; // s.gain("s", .2); // for single wav 
// s.element_sync(); //s.no_sync(); //s.full_sync();     //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

while(1) {
	     100::ms => now;
}
 
