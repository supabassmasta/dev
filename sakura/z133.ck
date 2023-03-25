class PSYBASSx extends SYNT{

    1 => own_adsr;
    

    inlet => PowerADSR padsrin => TriOsc s => LPF filter =>PowerADSR padsrout => outlet;   
    
    1.0 => s.width;

    .25 => padsrin.gain;
    padsrin.set(0::ms, data.tick  , .7 , 200::ms);
    padsrin.setCurves(.6, 7., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

    padsrout.set(1::ms, data.tick* 2/2, .000001 , 16 * 10::ms);
    padsrout.setCurves(.6, 2., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
        1.8 => s.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(1::ms, data.tick / 2 , .0000001, data.tick / 4);
    padsr.setCurves(.3, 2.0, .5);
    1.2 => filter.Q;
    48 => base.next;
    250 => variable.next;

    // ADSR Trigger
    //padsr.keyOn(); padsr.keyOff();

    // fun void auto_off(){
      //     data.tick / 4 => now;
      //     padsr.keyOff();
      // }
      // spork ~ auto_off();

      fun void filter_freq_control (){ 
            while(1) {
                    filter_freq.last() => filter.freq;
                          1::ms => now;
                              }
      } 
      spork ~ filter_freq_control (); 


            fun void on()  {padsr.keyOn(); padsrin.keyOn(); padsrout.keyOn(); 0.5 => s.phase;}  fun void off() {padsr.keyOff(); padsrin.keyOff(); padsrout.keyOff(); }  fun void new_note(int idx)  {   } 0 => own_adsr;
} 
class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SqrOsc s[synt_nb];
Gain final => outlet; .8 => final.gain;

inlet => detune[i] => s[i] => final; .40 => s[i].width;   1. => detune[i].gain;    .6 => s[i].gain; i++;  
//inlet => detune[i] => s[i] => final;    1.01 => detune[i].gain;    .3 => s[i].gain; i++;  


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

class synt1 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;

fun void  LOOPLAB  (){ 
  SinOsc sin0 =>  blackhole;
  6.0 => sin0.freq;
  0.12 => sin0.gain;

  while(1) {

    sin0.last()  + .5 =>  s.width;

     1::ms => now;
    //-------------------------------------------
  }
} 
spork ~ LOOPLAB();
//LOOPLAB(); 

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 
TONE t;
//t.reg(PSYBASSx s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
// 5_5_ 6___ 5_5_ 6___ 
//5_6_ 7_6_ 5_6!5 !3___
//2_0_ 2_3_ 2_0_ A___
//2_0_ 2_3_ 2_0_ A___

//!5__5 __5_ 5__5 __5_ 66__ ____ ____ 5!6!5!6 
//!5__5 __5_ 5__5 __5_ 66__ ____ ____ 5!6!5!6 
//!555_ ___5 !666_ ____ 7!6!7!5 __7_ 666_ ____ 5555 ____6666!5555 !3333 ____ ____ ____
//
//
//2__2 __2_ 0__0 __0_ 2__2 __2_ 3___ 3___ 2_2_ __2_ 0__0  __0_ A__A __A_ A_A_ A___
//2__2 __2_ 0__0 __0_ 2__2 __2_ 3___ 3___ 2_2_ __2_ 0__0  __0_ A__A __A!0 !A!0!A_ A___

"{c *4 
!5555 5555 5555 5___ 6666 6___ ____ ____ 
!5555 555_ 5__5 __5_ 66__ ____ ____ ____ 
!555_ ___5 !666_ ____ 7!6!7!5 __7_ 666_ ____ 5555 ____6666!5555 !3333 ____ ____ ____
2222 222_ 0000 000_ 2__2 __2_ 3333 3___ 2222 __2_ 0000  000_ A__A __AA AAAA A___
2222 222_ 0000 0_0_ 2__2 __2_ 3333 3___ 2222 __2_ 0__0  __0_ A__A __A!0 !A!0!A_ A___

" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(9 * 10 /* Base */, 4 * 100 /* Variable */, 1.5 /* Q */);
stsynclpfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.4 /* Sustain */, .3 /* Relative Sustain dur */, 0.3 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 23* 10.0 /* freq */ , 1.1 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STGVERB stgverb;
stgverb.connect(last $ ST, .004 /* mix */, 1 * 11. /* room size */, 9 * 10::ms /* rev time */, 0.0 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
