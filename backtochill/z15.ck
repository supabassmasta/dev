class BWG0 extends SYNT{
    inlet => blackhole;

    BandedWG bwg  =>  outlet; 
0.0360671  => bwg.pluck; 
0.032666  => bwg.bowRate; 
bwg.controlChange( 2,  4.583602  /* bowPressure */ ); 
bwg.controlChange( 4,  4.070503 /* bowMotion */); 
bwg.controlChange( 8,  9.637506 /* strikePosition */); 
bwg.controlChange( 11,  7.892551 /* vibratoFreq */); 
bwg.controlChange( 1,  5.437519 /* gain */); 
bwg.controlChange( 128,  1.378086 /* bowVelocity */); 
bwg.controlChange( 64,  .736026 /* setStriking */); 
bwg.controlChange( 16,  2.000000 /* preset */);

    fun void f1 (){ 
      1::samp => now;
      inlet.last() => bwg.freq;
      5.8 => bwg.noteOn;
       } 
       
        

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { spork ~ f1 ();} 0 => own_adsr;
}

TONE t;
t.reg(BWG0 s1);
t.reg(BWG0 s2);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c *4  
____ ____ ____ ____
____ ____ ____ ____
____ ____ 8___ ____

____ ____ ____ ____
____ ____ ____ ___5
____ ____ ____ ____
____ ____ ____ ____

" => t.seq;
0.43 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 0::ms, 1., 4000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(2::ms, 0::ms, 1., 4000::ms);
t.adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 
STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .7);  ech $ ST @=>  last; 

//STREV2 rev; // DUCKED
//rev.connect(last $ ST, .2 /* mix */);      rev $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, 2*data.tick /* period */, 0.5 /* phase 0..1 */ );       autopan $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
