SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); //
SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//M__M t__S  M_M_ t___    M___ t__S  M_M_ t_M_
//M___ t__M  M_M_ t___    M___ t__S  M__M t_M_

"*4
M___ t__S  M_M_ tuM_     M__M t__M  M_M_ t_M_    
M___ t__S  M_M_ tuM_     M__M t__M  MSM_ tuMu    


" => s.seq;
.8 * data.master_gain => s.gain; //
s.gain("u", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STFILTERX stresx0; RES_XFACTORY stresx0_fact;
stresx0.connect(last $ ST ,  stresx0_fact, 5* 10.0 /* freq */ , 0.3 /* Q */ , 1 /* order */, 1 /* channels */ );       stresx0 $ ST @=>  last;  
3. => stresx0.gain;

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(s $ ST , 0.7 /* static gain */  );       stgain $ ST @=>  last; 


STCOMPRESSOR stcomp;
2. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.4 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   
1.2 => stcomp.gain;

while(1) {
       100::ms => now;
}
 
