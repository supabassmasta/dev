SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
"../_SAMPLES/Sula Mae Jazz vocals/C3_Aahh__387_SP_02.wav" => s.wav["a"];  // act @=> s.action["a"]; 
"../_SAMPLES/Sula Mae Jazz vocals/F2_Oohh__387_SP_01.wav" => s.wav["b"];  // act @=> s.action["a"]; 
"../_SAMPLES/Sula Mae Jazz vocals/F2_Oohh__387_SP_01.wav" => s.wav["c"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"b___ ____
 ____ ____
 ____ ____
 ____ ____
 a___ a___
 ____ ____
 c___ c___
 ____ ____
" => s.seq;
.3 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

// fix tuning
.97 => s.wav_o["b"].wav0.rate;
2 * .97 => s.wav_o["c"].wav0.rate;

STGVERB stgverb;
stgverb.connect(last $ ST, .3 /* mix */, 6 * 10. /* room size */, 6::second /* rev time */, 0.0 /* early */ , 0.2 /* tail */ ); stgverb $ ST @=>  last; 

STCUTTER stcutter;
"1111 
*8 
1_1_1_1_
1_1_1_1_
1_1_1_1_
1_1_1_1_
1_1_1_1_
1_1_1_1_
1_1_1_1_
1_1_1_1_
:8
1111
" => stcutter.t.seq;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 


while(1) {
       100::ms => now;
}
 
