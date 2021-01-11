class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
    inlet => Gain fact => SawOsc s2 =>  outlet; 
    2. => fact.gain;
      .5 => s.gain;
      .25 => s2.gain;

TriOsc tri0 =>  s;
29.0 => tri0.freq;
0.0 => tri0.gain;
0.8 => tri0.width;


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 



TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
!1!1_!1  !1!1 +6!1 -6!1
!1!1_!1  !1!1 +6!1 -6!2
!1!1_!1  !1!1 +6!1 -6!1
!1!1_!1  !1!1 +6!1 -6!0

!1!1_!1  !1!1 +6!1 -6!1
!1!1_!B  !1!1 +6!1 -6!2
!1!1_!1  !1!1 +6!1 -6!1
!1!1_!1  !1!3 +6!1 -6!0

" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STOVERDRIVE stod;
stod.connect(last $ ST, 50.1 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

0.1 => stod.gain;


STSYNCFILTERX stfilter;LPF_XFACTORY stfilterfactory;
stfilter.freq(100 /* Base */, 5 * 100 /* Variable */, 5. /* Q */);
stfilter.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stfilter.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stfilter.connect(last $ ST ,  stfilterfactory, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stfilter $ ST @=>  last; 
/// CONNECT THIS to play on freq target //     => stfilter.nio.padsr;

STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 0 /* min */, 144 * 100 /* max */, 50::ms /* transition_dur */);
stepc.out =>  stfilter.nio.padsr;


STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][2] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

<<<"**********************************">>>;
<<<"*      ACID SYNT                 *">>>;
<<<"*   lpd 1.1 target freq filter   *">>>;
<<<"*   lpd 1.2 output volume        *">>>;
<<<"**********************************">>>;



while(1) {
       100::ms => now;
}
 

