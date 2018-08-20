class synt0 extends SYNT{
    inlet => blackhole;

    BandedWG bwg  =>  outlet; 
0.721442  => bwg.pluck; 
0.982707  => bwg.bowRate; 
bwg.controlChange( 2,  37.294487  /* bowPressure */ ); 
bwg.controlChange( 4,  58.331798 /* bowMotion */); 
bwg.controlChange( 8,  113.101567 /* strikePosition */); 
bwg.controlChange( 11,  53.811021 /* vibratoFreq */); 
bwg.controlChange( 1,  33.395608 /* gain */); 
bwg.controlChange( 128,  60.081363 /* bowVelocity */); 
bwg.controlChange( 64,  91.122568 /* setStriking */); 
bwg.controlChange( 16,  2.000000 /* preset */); 
 
    fun void f1 (){ 
      1::samp => now;
      inlet.last() => bwg.freq;
      .8 => bwg.startBowing;
       } 
       
        

        fun void on()  { spork ~ f1 ();}  fun void off() { /*1.0 => bwg.stopBowing;*/ }  fun void new_note(int idx)  { } 0 => own_adsr;
}

TONE t;
t.reg(synt0 s1);
t.reg(synt0 s2);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c :4 
11__ 33__
11__ 44__
" => t.seq;
1.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(5::ms, 0::ms, 1., 4000::ms);
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
 
