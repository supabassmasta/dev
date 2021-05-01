13 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////
fun void KICK(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
.2 => s.wav_o["m"].wav0.rate;
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .03 /* mix */, 5 * 10. /* room size */, 3::second /* rev time */, 0.2 /* early */ , 0.7 /* tail */ ); stgverb $ ST @=>  last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 3* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 2 /* channels */ );       stlpfx0 $ ST @=>  last;  

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(s $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STADSRC stadsrc;
stadsrc.connect(last, HW.launchpad.keys[16*6 + 6] /* pad 1:1 */ /* controler */, 10::ms /* attack */, 10::ms /* release */, 1 /* default_on */, 0  /* toggle */); stadsrc $ ST @=> last; 

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ KICK("*4 sss___");
fun void  SNR  (string seq){ 
   
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // 
SET_WAV.ACOUSTIC(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  

seq => s.seq;
.5 * data.master_gain => s.gain; // 
s.gain("a", .3); // for single wav 
s.gain("b", .2); // for single wav 
s.gain("u", .5); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //
s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
1.5=> s.wav_o["u"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STADSRC stadsrc;
stadsrc.connect(last, HW.launchpad.keys[16*6 + 6] /* pad 1:1 */ /* controler */, 10::ms /* attack */, 10::ms /* release */, 1 /* default_on */, 0  /* toggle */); stadsrc $ ST @=> last; 


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

STADSRC stadsrc;
stadsrc.connect(last, HW.launchpad.keys[16*6 + 6] /* pad 1:1 */ /* controler */, 10::ms /* attack */, 10::ms /* release */, 1 /* default_on */, 0  /* toggle */); stadsrc $ ST @=> last; 


  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}
////////////////////////////////////////////////////////////////////////////////////////////
fun void  SINGLEWAV  (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer);
   
   g => s.gain;

   file => s.read;

   s.length() => now;
} 

//   spork ~   SINGLEWAV("../_SAMPLES/", .4); 
////////////////////////////////////////////////////////////////////////////////////////////
fun void  THUNDER  (){ 
SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// 
"../_SAMPLES/thunder/446753__bluedelta__heavy-thunder-strike-no-rain-quadro.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"a___ ____ ____ ____ ____ ____" => s.seq;
1.2 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //
s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
stbpfx0.connect(last $ ST ,  stbpfx0_fact, 16* 100.0 /* freq */ , 0.7 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  

STCOMPRESSOR stcomp;
9. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   
4.5 => stcomp.gain;

STFILTERX stresx0; RES_XFACTORY stresx0_fact;
stresx0.connect(last $ ST ,  stresx0_fact, 13* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stresx0 $ ST @=>  last;  

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(stcomp $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 
   
   24 * data.tick => now;
} 




////////////////////////////////////////////////////////////////////////////////////////////

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

SYNC sy;
sy.sync(16 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1 *data.tick => w.fixed_end_dur;
//4 * data.tick =>  w.wait; 


while(1) {
//   spork ~   SINGLEWAV("../_SAMPLES/la boule/la boule loop1+dohl.wav", .4); 
//   spork ~   SINGLEWAV("../_SAMPLES/la boule/la boule loop1+dohl.wav", .4); 
//16 * data.tick =>  w.wait; 

//spork ~   THUNDER (); 
//16 * data.tick =>  w.wait; 

//spork ~   SINGLEWAV("../_SAMPLES/la boule/la boule musicboxF.wav", .05); 
spork ~ KICK("*4 m___ ____ ____  ____ m___ ____ ____  ___m  ____ ____");
spork ~   SNR ("*4 ____ ____ u___  ____ ____ ____ u___  ____ "); 
spork ~   RIDE ("*4 z__x z___ z__x  _z__ z__x z___ z__x  _z_x ____ ____"); 

8 * data.tick =>  w.wait; 
spork ~ KICK("*4 m___ ____ ____  ____ m___ ____ ___m  ___m ____ ____");
spork ~   SNR ("*4____ _aa_ u___  ____ ___b _b__ u___  __q_  "); 
spork ~   RIDE ("*4 z__x z___ z__x  _z__ z__x z___ z__x  _z_x____ ____ "); 

8 * data.tick =>  w.wait; 

//   spork ~   SINGLEWAV("../_SAMPLES/la boule/la boule musicboxF.wav", .05); 
//   spork ~ KICK("*4 m___ ____ ____  ____ m___ ____ ____  ___m  ____ ____");
//   spork ~   SNR ("*4 ____ ____ u___  ____ ____ ____ u___  ____ "); 
//   spork ~   RIDE ("*4 z__x z___ z__x  _z__ z__x z___ z__x  _z_x ____ ____"); 
//   
//   8 * data.tick =>  w.wait; 
//   spork ~ KICK("*4 m___ ____ ____  ____ m___ ____ ___m  ___m ____ ____");
//   spork ~   SNR ("*4____ _aa_ u___  ____ ___b _b__ u___  __q_  "); 
//   spork ~   RIDE ("*4 z__x z___ z__x  _z__ z__x z___ z__x  _z_x____ ____ "); 
//   
//   8 * data.tick =>  w.wait; 

}
 
