fun void  BEAT  (string seq){ 
   
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // 
SET_WAV.ACOUSTIC(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
"../_SAMPLES/la boule/triphopKick.wav" => s.wav["m"];  // act @=> s.action["a"]; 
"../_SAMPLES/la boule/triphopKick.wav" => s.wav["n"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  

seq => s.seq;
.5 * data.master_gain => s.gain; // 
s.gain("a", .3); // for single wav 
s.gain("b", .2); // for single wav 
s.gain("u", .5); // for single wav 
s.gain("m", 1.8); // for single wav 
s.gain("n", 1.8); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //
s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
1.5=> s.wav_o["u"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

//STADSRC stadsrc;
//stadsrc.connect(last, HW.launchpad.keys[16*6 + 6] /* pad 1:1 */ /* controler */, 10::ms /* attack */, 10::ms /* release */, 1 /* default_on */, 0  /* toggle */); stadsrc $ ST @=> last; 

STADSR stadsr;1 => stadsr.disconnect_mode_off;
stadsr.set(10::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 100::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 

MASTER_STADSR.reg(stadsr, 1);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}
fun void  RIDE  (string seq){ 
   
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // 
SET_WAV.ACOUSTIC(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  

seq => s.seq;
.1 * data.master_gain => s.gain; // 
//s.sync(4*data.tick);// s.element_sync(); 
s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

//STADSRC stadsrc;
//stadsrc.connect(last, HW.launchpad.keys[16*6 + 6] /* pad 1:1 */ /* controler */, 10::ms /* attack */, 10::ms /* release */, 1 /* default_on */, 0  /* toggle */); stadsrc $ ST @=> last; 

STADSR stadsr;1 => stadsr.disconnect_mode_off;
stadsr.set(10::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 100::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 

MASTER_STADSR.reg(stadsr, 1);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

SYNC sy;
sy.sync(16 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
16 *data.tick => w.fixed_end_dur;
//4 * data.tick =>  w.wait; 


while(1) {
spork ~ BEAT ("*4 m___ ____ u___  ____ m___ ____ u___  ___m :4 ___ ____ "); 
spork ~ RIDE ("*4 z__x z___ z__x  _z__ z__x z___ z__x  _z_x ____ ____"); 

8 * data.tick =>  w.wait; 
spork ~ BEAT ("*4 m___ _aa_ u___  ____ m__b _b__ u__m  __qn :4 ____ ____  "); 
spork ~ RIDE ("*4 z__x z___ z__x  _z__ z__x z___ z__x  _z_x____ ____ "); 

8 * data.tick =>  w.wait; 

}
