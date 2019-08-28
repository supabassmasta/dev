class BWG0 extends SYNT{
    inlet => blackhole;

    BandedWG bwg  =>  outlet; 

0.426246  => bwg.pluck; 
0.680029  => bwg.bowRate; 
bwg.controlChange( 2,  28.830611  /* bowPressure */ ); 
bwg.controlChange( 4,  77.396553 /* bowMotion */); 
bwg.controlChange( 8,  65.867153 /* strikePosition */); 
bwg.controlChange( 11,  22.405772 /* vibratoFreq */); 
bwg.controlChange( 1,  91.732982 /* gain */); 
bwg.controlChange( 128,  6.458138 /* bowVelocity */); 
bwg.controlChange( 64,  64.465172 /* setStriking */); 
bwg.controlChange( 16,  3.000000 /* preset */); 

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
"   
____
_1__
____
____

____
_8__
____
____

" => t.seq;
0.15 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 0::ms, 1., 4000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(2::ms, 0::ms, 1., 4000::ms);
t.adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 2 / 4 , .7);  ech $ ST @=>  last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 
//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

//STREV2 rev; // DUCKED
//rev.connect(last $ ST, .2 /* mix */);      rev $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
