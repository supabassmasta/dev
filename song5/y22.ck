SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); 
SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // "test.wav" => s.wav["a"];  
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4 k_k_  s__u _s__ kk__" => s.seq;
//"   S_k_  _k_k ____ k__k" => s.seq;
//"   ____  ____ ____ ____" => s.seq;
//"   ____  ____ ____ ____" => s.seq;

.6 => s.gain; // s.gain("s", .2); // for single wav 


// s.element_sync(); //s.no_sync(); //s.full_sync();  
16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

STECHOC ech;
ech.connect(s $ ST , HW.nano.potar[1][5] /* freq */ , HW.nano.potar[1][6] /* Q */ );  

STLPFC lpfc;
lpfc.connect(ech $ ST , HW.nano.potar[1][1] /* freq */  , HW.nano.potar[1][2] /* Q */  );  

STHPFC hpfc;
hpfc.connect(lpfc $ ST , HW.nano.potar[1][3] /* freq */  , HW.nano.potar[1][4] /* Q */  );  

while(1) {
	     100::ms => now;
}
 

