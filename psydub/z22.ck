SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// 
SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4 _H_I __H_ ____ _I__ ____ ____ HH__ ____" => s.seq;
// s.element_sync(); //s.no_sync(); //s.full_sync();     //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

STAUTOPAN autopan;
autopan.connect(s $ ST, .9 /* span 0..1 */, 5*data.tick /* period */, 0.95 /* phase 0..1 */ );  

STREV1 rev;
rev.connect(autopan $ ST, .3 /* mix */); 

while(1) {
	     100::ms => now;
}
 
