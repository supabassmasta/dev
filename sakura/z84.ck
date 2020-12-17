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


STCROSSOUT stcrossout;
stcrossout.connect(last $ ST );   stcrossout$ ST @=>  last; 
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


STROTATE strot;
strot.connect(stcrossout.AUX $ ST , 0.6 /* freq */  , 0.8 /* depth */, 1.0 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
//strot.connect(last $ ST , 0.6 /* freq */  , 0.8 /* depth */, 1.0 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
// => strot.sin0;  => strot.sin1; // connect to make freq change 
1.5 => strot.gain;


//STFLANGER flang;
//flang.connect(stcrossout.AUX $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */); 

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */); 

while(1) {
  8* data.tick => now;
  stcrossout.to_aux(4 * data.tick);
  8* data.tick => now;
  stcrossout.to_main(4 * data.tick);


}
 
