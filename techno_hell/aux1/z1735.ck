SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
"../../_SAMPLES/owl/owl1.wav" => s.wav["a"];  // act @=> s.action["a"]; 
"../../_SAMPLES/owl/owl2.wav" => s.wav["b"];  // act @=> s.action["a"]; 
"../../_SAMPLES/owl/owl3.wav" => s.wav["c"];  // act @=> s.action["a"]; 
"../../_SAMPLES/owl/owl4.wav" => s.wav["d"];  // act @=> s.action["a"]; 
"../../_SAMPLES/owl/owl5.wav" => s.wav["e"];  // act @=> s.action["a"]; 
"../../_SAMPLES/owl/owl6.wav" => s.wav["f"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//a___ ____ b___ ____
//c___ ____ d___ ____
"
____ ____ ____ e___
____ ____ ____ f___

" => s.seq;
1.5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 4 / 4 , .2);  ech $ ST @=>  last;


//STGVERB stgverb;
//stgverb.connect(last $ ST, .001 /* mix */, 15 * 10. /* room size */, 3::second /* rev time */, 0.1 /* early */ , 0.2 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
