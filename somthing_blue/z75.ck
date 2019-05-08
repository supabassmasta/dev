class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;
      .1 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // 
t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 
851_ ____ ____ ____
____ ____ ____ ____
58c_ ____ ____ ____
____ ____ ____ ____
418_ ____ ____ ____
____ ____ ____ ____
185_ ____ ____ ____
____ ____ ____ ____

851_ ____ ____ ____
____ ____ ____ ____
58c_ ____ ____ c_5_
____ ____ ____ ____
418_ ____ 48__ ____
____ ____ ____ __18
185_ ____ ____ ____
____ ____ ____ ____
" => t.seq;
1.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 2400  /* f_var */, 3::second / (5 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 

