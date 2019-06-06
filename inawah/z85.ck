class synt0 extends SYNT{

    8 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    TriOsc s[synt_nb];
    Gain final => outlet; .3 => final.gain;

    inlet => detune[i] => s[i] => final; .03 => s[i].width;   1. => detune[i].gain;    .9 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final; .03 => s[i].width;   2. => detune[i].gain;    .6 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final; .03 => s[i].width;   3. => detune[i].gain;    .6 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final; .03 => s[i].width;   4. => detune[i].gain;    .4 => s[i].gain; i++;  

//    inlet => TriOsc s =>  outlet; 
//      .5 => s.gain;
//    .03 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(SUPERSAW2 s1);  //data.tick * 8 => t.max; 
10::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" {c *6
4_5_6_5_6_7_
6_7_8_7_8_9_
}c
1_2_3_2_3_4_
3_4_5_
*2 4_5_6_5_6_7_
:2 8_____ ______

" => t.seq;
1.5 * data.master_gain => t.gain;
t.sync(8*data.tick);// t.element_sync();// 
//t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
1 * data.tick => t.the_end.fixed_end_dur;
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 5::ms, .3, 400::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


//STWPDiodeLadder stdl;
//stdl.connect(last $ ST , 3 * 1000 /* cutoff */  , 3. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 

//STSYNCWPDiodeLadder stsyncdl;
//stsyncdl.freq(35*100 /* Base */, 69 * 100 /* Variable */, 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */ );
//stsyncdl.adsr_set(.1 /* Relative Attack */, .1/* Relative Decay */, 0.5 /* Sustain */, .3 /* Relative Sustain dur */, 0.2 /* Relative release */);
//stsyncdl.connect(t $ ST, t.note_info_tx_o); stsyncdl $ ST @=>  last;  

//STFILTERMOD fmod;
//fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 10 * 100 /* f_base */ , 30 * 100  /* f_var */, 1::second / (16 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STLHPFC lhpfc;
lhpfc.connect(last $ ST , HW.lpd8.potar[1][7] /* freq */  , HW.lpd8.potar[1][8] /* Q */  );       lhpfc $ ST @=>  last; 


STAUTOPAN autopan;
autopan.connect(last $ ST, .2 /* span 0..1 */, 4*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][5] /* gain */  , 4. /* static gain */  );       gainc $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .3 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}


