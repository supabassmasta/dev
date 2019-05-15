class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;
    .03 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; 
10::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.ion();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" {2 *6
A21A21
A21A21
A21A21
A21A21
265265
265265
143143
143143

" => t.seq;
3.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 5::ms, .3, 400::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


STWPDiodeLadder stdl;
stdl.connect(last $ ST , 8 * 1000 /* cutoff */  , 7. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 

//STSYNCWPDiodeLadder stsyncdl;
//stsyncdl.freq(35*100 /* Base */, 69 * 100 /* Variable */, 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */ );
//stsyncdl.adsr_set(.1 /* Relative Attack */, .1/* Relative Decay */, 0.5 /* Sustain */, .3 /* Relative Sustain dur */, 0.2 /* Relative release */);
//stsyncdl.connect(t $ ST, t.note_info_tx_o); stsyncdl $ ST @=>  last;  

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 300 /* f_base */ , 30 * 100  /* f_var */, 1::second / (16 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][5] /* gain */  , 4. /* static gain */  );       gainc $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .3 /* mix */);     rev  $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
