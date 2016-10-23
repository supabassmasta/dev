SEQ s;  //data.tick * 8 => s.max;  
SET_WAV.VOLCA(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
":2  s_ s_s_ s_s_ s_s_ s_" => s.seq;
// s.element_sync(); s.no_sync(); s.full_sync();     //s.print();
// s.mono() => dac; s.left() => dac.left; s.right() => dac.right;
s.go(); 

STECHO ech;
ech.connect(s $ ST , data.tick / 3, .96); 


STAUTOPAN autopan;
autopan.connect(ech $ ST, -0.9 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );  

STREV1 rev;
rev.connect(autopan $ ST, .0 /* mix */); 

while(1) {
       100::ms => now;
}
 
