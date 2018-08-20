class BWG0 extends SYNT{
    inlet => blackhole;

    BandedWG bwg  =>  outlet; 

0.175412  => bwg.pluck; 
0.869230  => bwg.bowRate; 
bwg.controlChange( 2,  115.706523  /* bowPressure */ ); 
bwg.controlChange( 4,  32.258742 /* bowMotion */); 
bwg.controlChange( 8,  42.431364 /* strikePosition */); 
bwg.controlChange( 11,  65.808262 /* vibratoFreq */); 
bwg.controlChange( 1,  96.573335 /* gain */); 
bwg.controlChange( 128,  62.514321 /* bowVelocity */); 
bwg.controlChange( 64,  2.955549 /* setStriking */); 
bwg.controlChange( 16,  0.5 /* preset */); 

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
"}c *2  
1_5_ 3___
1|5_5|8_ 3__8
1_5_ 4___
1|5_5|8_ 4_3_



" => t.seq;
0.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 0::ms, 1., 4000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 
//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

//STREV2 rev; // DUCKED
//rev.connect(last $ ST, .2 /* mix */);      rev $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
