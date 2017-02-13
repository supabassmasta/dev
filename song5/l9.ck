class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet;   
        .3 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; 
t.reg(synt0 s2);  //data.tick * 8 => t.max; 
//160::ms => t.glide;  // t.lyd(); 
t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//" *4 !0!0!0!0!0!0!0!5!0!0!7!0!3!4" => t.seq;
":8 }c}c1_|5 " => t.seq;


//" *4 _0_0 _0!0!0" => t.seq;
//"    _4_0 _0!5!0" => t.seq;
.9 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2400::ms, 0::ms, 1., 2400::ms);
t.adsr[1].set(2400::ms, 0::ms, 1., 2400::ms);
t.go(); 

//STDUCK duck;
//duck.connect(t $ ST); 

STREV1 rev;
rev.connect(t $ ST, .7 /* mix */); 

while(1) {
       100::ms => now;
}
 
