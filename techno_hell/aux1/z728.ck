class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //
25::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
8351 ____ ____ ____  ____ ____ ____ ____
____ ____ ____ ____  ____ ____ ____ ____
1728 ____ ____ ____  ____ ____ ____ ____
____ ____ ____ ____  ____ ____ ____ ____
8461 ____ ____ ____  ____ ____ ____ ____
____ ____ ____ ____  ____ ____ ____ ____
07251 ___ ____ ____  ____ ____ ____ ____
____ ____ ____ ____  ____ ____ ____ ____


" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 5 /* Q */, 2 * 600 /* f_base */ , 2 * 400  /* f_var */, 1::second / (15 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
