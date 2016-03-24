SEQ s;  //data.tick * 8 => s.max;  
SET_WAV.VOLCA(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2 k|l|m ++++e|h k|l|m|D e|h" => s.seq;
// "*2 k|l|m _ k|l|m|D _ " => s.seq;
// "*2 k|l|m _ k|l|m _ " => s.seq;
// "*2 k|l|m _ k|l _ " => s.seq;
 s.element_sync(); //s.no_sync(); s.full_sync();     //s.print();
// s.mono() => dac; s.left() => dac.left; s.right() => dac.right;
s.go(); 

while(1) {
	     100::ms => now;
}
		
