SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // 
SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
/*
k_k_ ____ __k_ xa_b   k___ ___s _sk_ x__b
k_k_ ____ __k_ x___   k___ ___U _sk_ x__a
k_k_ ____ __k_ x__U   k___ ___b _sk_ x_k_

*/

" *4
k___ ____ __k_ x___   k___ ____ __k_ x___
k_ka ____ __k_ x___   k___ __k_ _bk_ x___
k__a __k_ __k_ x___   k___ __ka _sk_ x___
k_k_ __k_ __k_ x___   k___ __ka _sk_ x___

" => s.seq;
.9 * data.master_gain => s.gain; 
 s.gain("k", 1.2); // for single wav 
 s.gain("s", .2); // for single wav 
 s.gain("a", .5); // for single wav 
 s.gain("b", .5); // for single wav 
 s.gain("U", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); //
1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV ////
SEQ s2; SET_WAV.TRANCE(s2); s.add_subwav("k", s2.wav["k"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last;


//STLPF lpf;
//lpf.connect(last $ ST , 8 * 100 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

//STLHPFC2 lhpfc2;
//lhpfc2.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc2 $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
