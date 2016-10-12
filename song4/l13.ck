SEQ s;  //data.tick * 8 => s.max;  
SET_WAV.VOLCA(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
":2 (9 s_)9 s_" => s.seq;
// s.element_sync(); s.no_sync(); s.full_sync();     //s.print();
// s.mono() => dac; s.left() => dac.left; s.right() => dac.right;
s.go(); 

STECHO ech;
ech.connect(s $ ST , data.tick / 2, .7); 

STREV1 rev;
rev.connect(ech $ ST, .4 /* mix */); 

while(1) {
       100::ms => now;
}
 
