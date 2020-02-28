class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
}


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c {c {c 1" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STEPC stepc; stepc.init(HW.lpd8.potar[1][6], 0.2 /* min */, 1/* max */, 50::ms /* transition_dur */);
stepc.out =>  s0.inlet;
3 => s0.inlet.op;
 
STLPFC2 lpfc2;
lpfc2.connect(last $ ST , HW.lpd8.potar[1][7] /* freq */  , HW.lpd8.potar[1][8] /* Q */  );       lpfc2 $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][5] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 5 * 100 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .7);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STLIMITER stlimiter;
7. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   

STGAIN stgain;
stgain.connect(last $ ST , 0.5 /* static gain */  );       stgain $ ST @=>  last; 

<<<"^^^^^^^^^^^^^^^^^^^^^^^^^^^^">>>;
<<<"^^^^^^^^^^^^^^^^^^^^^^^^^^^^">>>;
<<<"^^^^ FROG Modulator ^^^">>>;
<<<"^^^^^^^^^^^^^^^^^^^^^^^^^^^^">>>;
<<<"^^^^^^^^^^^^^^^^^^^^^^^^^^^^">>>;

<<<"Potar 1.5 Gain before Echo ">>>;
<<<"Potar 1.6 Main synt freq ">>>;
<<<"Potar 1.7 LPF freq">>>;
<<<"Potar 1.8 LPF  Q">>>;


while(1) {
       100::ms => now;
}
 
