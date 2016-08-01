class synt0 extends SYNT{

    inlet => SinOsc s => ADSR a => outlet; 
      .3 => s.gain;

    a.set (1::ms, 1::ms, 0.3, 1::ms);
  fun void f1 (){ 
      3::ms => dur t1;
      7::ms => dur t2;

      for (0 => int i; i < 11      ; i++) {
        a.keyOn();
        t1 => now;
        a.keyOff();
        t2 => now;
      }
       


     } 
     
      
        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { spork ~ f1 ();}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();t.aeo(); t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c}c}c}c}c ceghke_AFGBOP_FJA035_ackn923__GA_TL " => t.seq;
 t.element_sync(); //t.no_sync(); t.full_sync();     //t.print();
// t.mono() => dac; t.left() => dac.left; t.right() => dac.right; t.raw => dac;
t.go(); 

while(1) {
       100::ms => now;
}
 
