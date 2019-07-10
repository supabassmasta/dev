SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
"../_SAMPLES/mongolian_step/snare_echo1.wav" => s.wav["a"];  // act @=> s.action["a"]; 
"../_SAMPLES/mongolian_step/snare_echo2.wav" => s.wav["b"];  // act @=> s.action["a"]; 
"../_SAMPLES/mongolian_step/snare_echo3.wav" => s.wav["c"];  // act @=> s.action["a"]; 
"../_SAMPLES/mongolian_step/snare_echo4.wav" => s.wav["d"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"
___d

" => s.seq;
2.8 * data.master_gain => s.gain; // 
s.gain("a", 1.4); // for single wav 
s.gain("b", 2.3); // for single wav 
s.gain("c", 1.4); // for single wav 
s.gain("d", 1.7); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 + 5::ms , .6);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 

