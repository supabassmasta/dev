SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); 
"../_SAMPLES/Kecak/kecak.wav" => s.wav["a"];  
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"a" => s.seq;
.3 => s.gain; // s.gain("s", .2); // for single wav 
// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

STRESC lpfc;
lpfc.connect(s $ ST , HW.lpd8.potar[3][2] /* freq */  , HW.lpd8.potar[3][3] /* Q */  );  

STGAINC gainc;
gainc.connect(lpfc $ ST , HW.lpd8.potar[3][1] /* gain */  , 4. /* static gain */  );  

STDUCK duck;
duck.connect(gainc $ ST); 




while(1) {
	     100::ms => now;
}
 

