class synt0 extends SYNT{
  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  SERUM0 s[synt_nb]; 
  Gain final => outlet; .3 => final.gain;

  26 => int n;
  0 => int k;

  inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  
  inlet => detune[i] => s[i] => final;    1.011 => detune[i].gain;    .1 => s[i].gain;   s[i].config(n, k) ; i++;  
  inlet => detune[i] => s[i] => final;    0.9981 => detune[i].gain;    .1 => s[i].gain;   s[i].config(n, k) ; i++;  

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;

}  


POLYTONE pt;

3 => pt.size;

// data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;//
8 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  

// /!\ Not managed for all TONE in POLY TONE
//pt.t[0].force_off_action();
// pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;

pt.dor();// pt.lyd();// pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
//pt.sync(4*data.tick);// pt.element_sync();//  pt.no_sync();//  pt.full_sync();

0.7 * data.master_gain =>  pt.gain_common;
// .6 * data.master_gain => pt.t[0].gain; // For individual gain

pt.t[0].reg(synt0 s0); 
pt.t[1].reg(synt0 s1); 
pt.t[2].reg(synt0 s2); 

pt.adsr0_set(1500::ms, 1000::ms, .8, 3000::ms); // Only works for ADSR 0
pt.adsr0_setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4}c}c" +=> pt.tseq[0];
":4}c}c" +=> pt.tseq[1];
":4}c}c" +=> pt.tseq[2];
"11_0" +=> pt.tseq[0];
"2_2_" +=> pt.tseq[1];
"__33" +=> pt.tseq[2];

pt.go();

// CONNECTIONS
pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
// pt.t[0] $ ST @=> ST @ last; 

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */); 

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 2.0 /* Q */, 40 * 100 /* freq base */, 31 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 12* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STGVERB stgverb;
stgverb.connect(last $ ST, .01 /* mix */, 6 * 10. /* room size */, 5::second /* rev time */, 0.1 /* early */ , 0.5 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
