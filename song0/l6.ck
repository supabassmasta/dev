class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet;   
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();t.aeo(); t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c 0_" => t.seq;
// t.element_sync(); t.no_sync(); t.full_sync();     //t.print();
 t.mono() => dac; //t.left() => dac.left; t.right() => dac.right; t.raw => dac;
 t.mono() => blackhole;
 t.mono() => Gain r => global_mixer.rev0;
 .3 => r.gain;
t.go(); 

while(1) {
       100::ms => now;
}
 
