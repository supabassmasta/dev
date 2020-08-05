


SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//"../../_SAMPLES/Aborigines/abo1.wav" => s.wav["a"];
"../_SAMPLES/Aborigines/aboscream0 warp.wav" => s.wav["b"];
"../_SAMPLES/Aborigines/aboscream1 warp.wav" => s.wav["d"];
"../_SAMPLES/Aborigines/aboscream2 warp.wav" => s.wav["e"];
"../_SAMPLES/Aborigines/aboscream3 warp.wav" => s.wav["f"];
"../_SAMPLES/Aborigines/aboscream4 warp.wav" => s.wav["g"];
"../_SAMPLES/Aborigines/aboscream5 warp.wav" => s.wav["h"];
"../_SAMPLES/Aborigines/aboscream6 warp comp.wav" => s.wav["i"];

 "
 ____ b___
 ____ d___
 ____ e___
 ____ f___
 ____ g___
 ____ h___
 ____ i___
 " => s.seq;
//"
//____ i___
//" => s.seq;
1.1 * data.master_gain => s.gain; //
s.gain("i", 0.4); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); //
8 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 6 * 10. /* room size */, 3::second /* rev time */, 0.1 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
