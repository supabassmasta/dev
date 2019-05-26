class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;
    .93 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //
26::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8

1538 ____  ____  ____ ____ ____  ____  ____  
____ ____  ____  ____ ____ ____  ____  ____  
8215 ____  ____  ____ ____ ____  ____  ____  
____ ____  ____  ____ ____ ____  ____  ____  
1853 ____  ____  ____ ____ ____  ____  ____  
____ ____  ____  ____ ____ ____  ____  ____  
8215 81__  ____  ____ ____ ____  ____  ____  
____ ____  ____  ____ ____ ____  ____  ____  
" => t.seq;
0.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STWPDiodeLadder stdl;
//stdl.connect(last $ ST , 2*100 /* cutoff */  , 7. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; A

STWPDiodeLadder stdl;
stdl.connect(last $ ST , 28*100 /* cutoff */  , 9. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 14 /* Q */, 600 /* f_base */ , 400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .7);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .8 /* span 0..1 */, 5*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

while(1) {
       100::ms => now;
}


