class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;
      .3 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //
20::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" }c
*2
____ ____ 63#4 1___ 
____ ____ ____ ____
____ ____ ___1/8 ____
____ ____ 5830 1___

____ ____ 5#45#4 1___ 
____ ____ ____ ____
____ ____ 8//1_#4 ____
____ __8_ 3__3 1___

" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

// DETUNE detune;
// detune.base_synt(s0 /* base synt, controlling others */);
// detune.reg_aux(synt0 aux1); /* declare and register aux here */
// detune.config_aux(1.01 /* detune percentage */, .6 /* aux gain output */ );  
// detune.reg_aux(synt0 aux2); /* declare and register aux here */
// detune.config_aux(0.994 /* detune percentage */, .6 /* aux gain output */ );  

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STDELAY stdelay;
stdelay.connect(last $ ST , data.tick * 2. / 4. /* static delay */ );       stdelay $ ST @=>  last;  

STAUTOPAN autopan;
autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STAUTOPAN autopan2;
autopan2.connect(t $ ST, .3 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(autopan $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
