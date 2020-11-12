class synt0 extends SYNT{

  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  SERUM0 s[synt_nb]; 
  Gain final => outlet; .3 => final.gain;

  27 => int n;
  1 => int k;

  inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;

} 



TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 1__1 __2_ !1!1!_1! 1_!1_" => t.seq;
1.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(100 /* Base */, 3 * 100 /* Variable */, 1.3 /* Q */);
stsynclpfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target // 
STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 1 /* min */, 44 * 100 /* max */, 50::ms /* transition_dur */);
stepc.out => stsynclpfx0.nio.padsr; 

STLHPFC2 lhpfc2;
lhpfc2.connect(last $ ST , HW.lpd8.potar[1][2] /* freq */  , HW.lpd8.potar[1][3] /* Q */  );       lhpfc2 $ ST @=>  last; 


STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 , .2);  ech $ ST @=>  last; 

//STAUTOPAN autopan;
//autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
