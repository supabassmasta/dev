class synt0 extends SYNT{

     8 => int synt_nb; 0 => int i;
     Gain detune[synt_nb];
     SqrOsc s[synt_nb];
     Gain final => outlet; .3 => final.gain;

     inlet => detune[i] => s[i] => final; .1 => s[i].width;   1. => detune[i].gain;    .6 => s[i].gain; i++;  
     inlet => detune[i] => s[i] => final; .1 => s[i].width;   1.0001 => detune[i].gain;    .4 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c{c 1//88/BB/11/ff/GG//1" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERMOD fmod;
fmod.connect( last , "HPF" /* "HPF" "BPF" BRF" "ResonZ" */, 5 /* Q */, 32 * 100 /* f_base */ , 64 * 100  /* f_var */, 1::second / (9 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STCUTTER stcutter;
"*8 __1__111____1_1_1__11_____1__1_" => stcutter.t.seq;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 + 10::ms , .8);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 8 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STDELAY stdelay;
stdelay.connect(ech $ ST , data.tick * 2. / 4. /* static delay */ );       stdelay $ ST @=>  last; 
STAUTOPAN autopan2;
autopan2.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 4 /* period */, 0.95 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
