SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"
____ ____ 
____ ____ 
____ ____ 
*4
k__k __kt  u_t_ t_st
ks_k kt_s ks_k  stuv

" => s.seq;
.5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 


STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 2 /* Q */, 2 /* order */, 2 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 
 // CONNECT THIS 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 100::ms /* Sustain dur */,  10::ms /* release */);
//stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
stadsr.connect(stfreelpfx0 $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff(); 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 
.6 => ech.gain;

///////////////// AUTOMATION ///////////////////////

Step stpauto =>  Envelope eauto =>  blackhole;
1.0 => stpauto.next;
100 => eauto.value; // INITIAL VALUE

eauto => stfreelpfx0.freq; 


//fun void f1 (){ 
//  while(1) {
//    eauto.last() => stfreelpfx0.freq; 
//    10::ms => now; // REFRESH RATE
//  }
//}
//spork ~ f1 ();

SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(32 * data.tick , -8 * data.tick /* offset */);

while(1) {
  9 * 1000.0 => eauto.target;
  8.0 * data.tick => eauto.duration;
  6 * data.tick => now;

  stadsr.keyOn();
  2 * data.tick => now;
  stadsr.keyOff();


  1 * 100.0 => eauto.target;
  1.0 * data.tick => eauto.duration  => now;

  24 * data.tick => now;
}
///////////////// AUTOMATION /////////////////////// 



while(1) {
       100::ms => now;
}
 
