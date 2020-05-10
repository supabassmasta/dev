

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // 
SET_WAV.TRIBAL1(s);//
"../_SAMPLES/tabla/kehr_vaa.wav" => s.wav["a"];
"../_SAMPLES/flute_trainer/tambourine.wav" => s.wav["b"];  // act @=> s.action["a"]; 
"../_SAMPLES/flute_trainer/bellF.wav" => s.wav["c"];  // act @=> s.action["a"]; 


// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"a|S___ b___ b___ b___" => s.seq;

 s.wav_o["a"].wav0.length() / (16 * data.tick)  => s.wav_o["a"].wav0.rate;

.9 * data.master_gain => s.gain; // 
s.gain("a", .4);
s.gain("b", .6); // for single wav 
s.gain("c", .8);
s.gain("S", .30);
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //
s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STGAIN stgain;
stgain.connect(last $ ST , 3.9 /* static gain */  );       stgain $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
