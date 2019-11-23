SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); //
SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4
____ ____ ____ ____
____ ____ ____ ____
____ ____ ssss ssss
____ ____ ____ ____
____ ____ ____ ____
____ ____ ____ ____
____ ____ SSSS SSSS
____ ____ ____ ____
" => s.seq;
.7 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 + 3::ms , 0.9);  ech $ ST @=>  last; 

STLIMITER stlimiter;
8. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl + .1 /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 1600 /* f_base */ , 5400  /* f_var */, 1::second / (5 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STFILTERMOD fmod2;
fmod2.connect( stlimiter $ ST , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 1600 /* f_base */ , 5400  /* f_var */, 1::second / (3 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .8 /* span 0..1 */, 5*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
