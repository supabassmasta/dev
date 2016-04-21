class synt0 extends SYNT{


    8 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    TriOsc s[synt_nb];
    Gain final =>  LPF f =>  outlet; .7 => final.gain;
//    final => ResonZ r => outlet;
    inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .3 => s[i].gain; .52=> s[i].width; i++;  
    inlet => detune[i] => s[i] => final;    1.001 => detune[i].gain;    .3 => s[i].gain; .45=> s[i].width; i++;  
    inlet => detune[i] => s[i] => final;    2.00 => detune[i].gain;    .2 => s[i].gain;  i++;  
    inlet => detune[i] => s[i] => final;    2.001 => detune[i].gain;    .2 => s[i].gain;  i++;  

   5290 => f.freq;
   2 => f.Q;

//    156 => r.freq;
//    6   => r.Q;
//    4 => r.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
}   


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  
t.aeo(); 
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":2{3{c 11114444" => t.seq;
 t.element_sync(); //t.no_sync(); t.full_sync();     //t.print();
// t.mono() => dac; t.left() => dac.left; t.right() => dac.right; t.raw => dac;
t.go(); 


while(1) {
       100::ms => now;
}


