class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c 15368" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

SEQ s;  //data.tick * 8 => s.max;  //
SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"kk*2_k" => s.seq;
.5 * data.master_gain => s.gain; // s.gain("s", .1); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> last; 


// class STCROSSIN extends ST {
// 
//   STADSR stadsr;
//   stadsr.left() => outl;
//   stadsr.right() => outr;
// 
//   STADSR stadsraux;
//   stadsraux.left() => outl;
//   stadsraux.right() => outr;
// 
//   fun void to_aux(dur d){ 
//     stadsr.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d /* release */);
//     stadsraux.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d/* release */);
//     stadsr.keyOff(); 
//     stadsraux.keyOn(); 
//     <<<"ST CROSS IN TO AUX">>>;
//   } 
// 
//   fun void to_main(dur d){ 
//     stadsr.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d /* release */);
//     stadsraux.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d/* release */);
//     stadsr.keyOn(); 
//     stadsraux.keyOff(); 
//     <<<"ST CROSS IN TO MAIN">>>;
//   } 
// 
//   fun void connect(ST @ main, ST @ aux) {
// 
//     stadsr.set(0::ms /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  0::ms /* release */);
//     stadsr.connect(main $ ST); 
// 
//     stadsraux.set(0::ms /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  100::ms/* release */);
//     stadsraux.connect(aux $ ST);
// 
//     stadsr.keyOn(); 
//     stadsraux.keyOff(); 
// 
//   }
// 
// }


STCROSSIN stcrossin;
stcrossin.connect(last $ ST /* main */, t $ ST);
// stcrossin.to_aux(4 * data.tick /* crossorver duration */); // SWITCH TO AUX IN
// stcrossin.to_main(4 * data.tick /* crossorver duration */);// SWITCH BACK TO MAIN IN 

//STCROSSIN stcrossin;
//stcrossin.connect(last $ ST /* main */, t $ ST);
// stcrossin.to_aux(4 * data.tick);
// stcrossin.to_main(4 * data.tick);

// class STCROSSOUT extends ST{
// 
//   ST IN;
// 
//   ST AUX;
// 
//   STADSR stadsr;
//   stadsr.outl => outl;
//   stadsr.outr => outr;
// 
//   STADSR stadsraux;
//   stadsraux.left() => AUX.outl;
//   stadsraux.right() => AUX.outr;
// 
//   fun void  go  (){ 
// 
// 
//     stadsr.set(0::ms /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  0::ms /* release */);
//     stadsr.connect(IN $ ST);  stadsr  $ ST @=>  last; 
//     stadsr.keyOn(); 
// 
//     stadsraux.set(0::ms /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  100::ms/* release */);
//     stadsraux.connect(IN $ ST);  stadsraux  $ ST @=>  last; 
//     stadsraux.keyOff(); 
// 
//     1::samp => now;
//   }
// 
//   fun void to_aux(dur d){ 
//     stadsr.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d /* release */);
//     stadsraux.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d/* release */);
//     stadsr.keyOff(); 
//     stadsraux.keyOn(); 
//     <<<"ST CROSS OUT TO AUX">>>;
// 
// //    1::samp => now;
//   } 
// 
//   fun void to_main(dur d){ 
//     stadsr.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d /* release */);
//     stadsraux.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d/* release */);
//     stadsr.keyOn(); 
//     stadsraux.keyOff(); 
//     <<<"ST CROSS OUT TO MAIN">>>;
// //    1::samp => now;
//   } 
// 
//   fun void connect(ST @ tone) {
//     tone.left() => IN.outl;
//     tone.right() => IN.outr;
//      
//     spork ~   go (); 
// 
//   }
// 
// }


//STCROSSOUT stcrossout;
//stcrossout.connect(last $ ST );   stcrossout$ ST @=>  last; 
// stcrossout.AUX // Aux output  
// stcrossout.to_aux( 4 * data.tick /* crossorver duration */);  // SWITCH TO AUX OUT
// stcrossout.to_main( 4 * data.tick /* crossorver duration */); // SWITCH BACK TO MAIN 

//STCROSSOUT stcrossout;
//stcrossout.connect(last $ ST );   stcrossout$ ST @=>  last; 
// stcrossout.AUX // Aux output  
//stcrossout.to_aux( 4 * data.tick /* crossorver duration */);  // SWITCH TO AUX OUT
//stcrossout.to_main( 4 * data.tick /* crossorver duration */); // SWITCH BACK TO MAIN

//STCROSSOUT stcrossout;
//stcrossout.connect(last $ ST, 4 * data.tick /* crossorver duration */ );   stcrossout$ ST @=>  last; 
// stcrossout.AUX // Aux output 


//STROTATE strot;
//strot.connect(stcrossout.AUX $ ST , 0.6 /* freq */  , 0.8 /* depth */, 1.0 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
//strot.connect(last $ ST , 0.6 /* freq */  , 0.8 /* depth */, 1.0 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
// => strot.sin0;  => strot.sin1; // connect to make freq change 
//1.5 => strot.gain;


//STFLANGER flang;
//flang.connect(stcrossout.AUX $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */); 

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */); 

while(1) {
  8* data.tick => now;
  stcrossin.to_aux(4 * data.tick);
  8* data.tick => now;
  stcrossin.to_main(4 * data.tick);


}
 
