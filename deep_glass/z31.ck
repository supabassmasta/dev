class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .3 => s.gain;
      .87 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
*4 }c
853135" => t.seq;
.23 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 3* 100 /* f_base */ , 2 * 100  /* f_var */, 1::second / (17 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, 11*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .1 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
