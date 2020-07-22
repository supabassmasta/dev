class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .8 => s.gain;

   TriOsc tri0 =>  OFFSET ofs0 => SinOsc sin0 =>  s;
//   10.0 => sin0.freq;
   9.0 => sin0.gain;

   10. => ofs0.offset;
   4. => ofs0.gain;

   1.1 => tri0.freq;
   1.0 => tri0.gain;
   0.1 => tri0.width;

 
 SinOsc sin1 =>  SqrOsc sqr0 =>  s;
 10.0 => sqr0.freq;
 52.0 => sqr0.gain;
 0.5 => sqr0.width;
 0.1 => sin1.freq;
 19.0 => sin1.gain;


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c *4
____ ____ ____ _8/1_
____ ____ ____ _1_1
____ ____ ____ __5/8
____ ____ ____ 1301
" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

//STFILTERMOD fmod;
//fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 200 /* f_base */ , 2400  /* f_var */, 1::second / (8 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
