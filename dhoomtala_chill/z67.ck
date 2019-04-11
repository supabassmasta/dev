SEQ s;  //data.tick * 8 => s.max;  //
SET_WAV.TRIBAL(s);// SET_WAV.VOLCA(s); //
//SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  

SEQ s2;

SET_WAV.ACOUSTIC(s2);
 s2.wav["i"] => s.wav["i"];

"
*4

h__h __h_ 
h__h i_h_ 
h_ih i_hi 
h_ih _ihh 
" => s.seq;
s.gain("h", .4); // for single wav 
s.gain("i", .15); // for single wav 
//.6 * data.master_gain => s.gain; //
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 
