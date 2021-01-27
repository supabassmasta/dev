class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .1 => s.width;
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
}

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //
20::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4
8653 2186 5386 5865
8653 2186 5386 5865
8653 2186 5865 8686 8686

" => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STAUTOFILTERX stautohpfx0; HPF_XFACTORY stautohpfx0_fact;
stautohpfx0.connect(last $ ST ,  stautohpfx0_fact, 3.0 /* Q */, 1 * 100 /* freq base */, 13 * 100 /* freq var */, data.tick * 21 / 2 /* modulation period */, 1 /* order */, 2 /* channels */ , 1::ms /* update period */ );       stautohpfx0 $ ST @=>  last;  

STAUTOPAN autopan;
autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .3);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
