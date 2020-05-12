class synt0 extends SYNT{

      8 => int synt_nb; 0 => int i;
      Gain detune[synt_nb];
      Step det_amount[synt_nb];
      SqrOsc s[synt_nb];
      Gain final => outlet; .8 => final.gain;

      inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
      inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
      inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c  G/ff//G " => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 8 /* Q */, 260 /* f_base */ , 4400  /* f_var */, 1::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STFILTERMOD fmod2;
fmod2.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 3400  /* f_var */, 1::second / (5 * data.tick) /* f_mod */);     fmod2  $ ST @=>  last; 


STLHPFC2 lhpfc;
lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 300 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

//STCOMPRESSOR stcomp;
//7. => float in_gain;
//stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 30::ms /* releaseTime */);   stcomp $ ST @=>  last;   

STLIMITER stlimiter;
4. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl  + 0.10/* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

<<<"~~~~~~~~~FROGGY FILTER~~~~~~~~~~">>>;
<<<"~~~  LPF freq  lpd8 1.1   ~~~~~~">>>;
<<<"~~~  LPF  Q    lpd8 1.2   ~~~~~~">>>;
<<<"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~">>>;

STGAIN stgain;
stgain.connect(last $ ST , 0.6 /* static gain */  );       stgain $ ST @=>  last; 



while(1) {
       100::ms => now;
}
 
