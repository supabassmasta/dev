SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // 
SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//kkkk kkkk kkkk kk *2k__k  :2
"
kkkk kkkk kkkk kk *4k___ k__k  :4
kkkk kkkk kkkk kk *4kk_k _k_k  :4
kkkk kkkk kkkk kk *4kk_k k__k  :4
kkkk kkkk kkkk kk *4k__k kk_k  :4
" => s.seq;
.6 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); //
1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// 
SEQ s2; SET_WAV.TRANCE(s2); s.add_subwav("k", s2.wav["l"]);  s.gain_subwav("k", 0, .25);
s.go();     s $ ST @=> ST @ last; 

STOVERDRIVE stod;
stod.connect(last $ ST, 2.8 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 
.6 => stod.gain;

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 35* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STDUCKMASTER duckm;
duckm.connect(last $ ST, 9. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 
while(1) {
       100::ms => now;
}
 
