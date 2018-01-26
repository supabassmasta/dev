SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);
//SET_WAV.VOLCA(s); 
//SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); 
SET_WAV.DUB(s); // SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*1 ____ ___  ____  ss__ ____ ___  ____  ____" => s.seq;
.4 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

STECHO ech;
ech.connect(s $ ST , data.tick * 1 / 3 , .95); 

STAUTOPAN autopan;
autopan.connect(ech $ ST, .9 /* span 0..1 */, 3*data.tick /* period */, 0.44 /* phase 0..1 */ );  

STDUCK duck;
duck.connect(autopan $ ST); 

STREV2 rev; // DUCKED
rev.connect(autopan $ ST, .1 /* mix */); 

while(1) {
       100::ms => now;
}
 
