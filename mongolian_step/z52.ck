class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
}

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *8 }c }c
____ ____ ____ ____ 
____ ____ __39 381_ 
____ ____ ____ ____ 
____ ____ ____ ____ 

____ ____ ____ ____ 
____ ____ __93 138_ 
____ ____ ____ ____ 
____ ____ ____ ____ 
" => t.seq;
0.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, .4, 40::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 3  , .9);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 3 /* Q */, 600 /* f_base */ , 4400  /* f_var */, 1::second / (3 * data.tick) + .1 /* f_mod */);     fmod  $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .3 /* span 0..1 */, 3*data.tick - 50::ms/* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 

