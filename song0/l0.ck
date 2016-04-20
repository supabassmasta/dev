SEQ s;  data.tick * 4 => s.max;  
SET_WAV.TABLA(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//"*2AB_C|a *4 efefef_:4Bc *4gghgi_f_dab" => s.seq;
"*2AB_C|a ____ " => s.seq;
"AB_C|a  e____" => s.seq;
"AB_C|a ____ " => s.seq;
"AB_C|a fgfg " => s.seq;
 s.element_sync();// s.no_sync(); s.full_sync();     //s.print();
// s.mono() => dac; s.left() => dac.left; s.right() => dac.right;
s.go(); 

while(1) {
	     100::ms => now;
}
 
