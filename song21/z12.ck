SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
" *2 
l_" => s.seq;
.8 * data.master_gain => s.gain; // 
s.gain("l", 1.5); // for single wav 
s.gain("v", 10.5); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

//STLIMITER stlimiter;
//9. => float in_gain;
//stlimiter.connect(last $ ST , in_gain /* in gain */, 1./in_gain + 0.0 /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 250::ms /* releaseTime */);   stlimiter $ ST @=>  last;   
//

//STLIMITER stlimiter;
//13. => float in_gainl;
//stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl + 0.2 /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 8::ms /* attackTime */ , 500::ms /* releaseTime */);   stlimiter $ ST @=>  last;   
//

STCOMPRESSOR stcomp;
1. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain + .03 /* out gain */, 0.1 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 4::ms /* attackTime */ , 50::ms /* releaseTime */);   stcomp $ ST @=>  last;   


while(1) {
       100::ms => now;
}
 
