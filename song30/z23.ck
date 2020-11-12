class synt0 extends SYNT{

  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  SERUM0 s[synt_nb]; 
  Gain final => outlet; .3 => final.gain;

  27 => int n;
  1 => int k;

  inlet => Gain mod => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  
  inlet =>  Gain mod2 => detune[i] => s[i] => final;    2. => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  


SinOsc sin0 =>  mod;sin0 =>  mod2;
10.0 => sin0.freq;
17 * 0.01 => sin0.gain;


  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;

} 



TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c !1////1 ____
     1////1 ___5 " => t.seq;
1.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(19::ms, 10::ms, 1., 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(100 /* Base */, 9 * 100 /* Variable */, 1.5 /* Q */);
stsynclpfx0.adsr_set(.4 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
sthpfx0.connect(last $ ST ,  sthpfx0_fact, 5* 10.0 /* freq */ , 3.0 /* Q */ , 2 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

//STAUTOPAN autopan;
//autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 4* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
