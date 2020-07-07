SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // 
//SET_WAV.TRIBAL1(s);
SET_WAV.TABLA(s);
// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4
____ ____ __a_ __b_ 
____ ____ c_c_ __a_ 
____ ____ ____ _xyz 
____ ____ __a_ __b_ 
____ ____ x_yz _z__ 
____ ____ _X_X __A_ 
" => s.seq;
1.5 * data.master_gain => s.gain; //
//s.gain("s", .4); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); //
2 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV ////
//SEQ s2; SET_WAV.TRANCE(s2); s.add_subwav("k", s2.wav["k"]); //
//s.gain_subwav("k", 0, .4);
s.go();     s $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .04 /* mix */, 5 * 10. /* room size */, 2::second /* rev time */, 0.1 /* early */ , 0.3 /* tail */ ); stgverb $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
