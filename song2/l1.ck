class synt0 extends SYNT{

    8 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    SinOsc s[synt_nb];
    Gain final => ABSaturator sat  => outlet; .3 => final.gain;
1 => sat.drive;
0 => sat.dcOffset;


    inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; i++;  

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
}


TONE t;
t.reg(synt0 s1); t.aeo(); //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();t.aeo(); t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c 1155 7774  6442 5533" => t.seq;
 t.element_sync();// t.no_sync(); t.full_sync();     //t.print();
 t.mono() => Gain fb => dac;
 fb => Gain rev => global_mixer.rev0;
 .4 => rev.gain;
 
 fb => Delay d => fb;
 data.tick * 2 => d.max => d.delay;
 .4 => d.gain;   

 // t.left() => dac.left; t.right() => dac.right; t.raw => dac;
t.go(); 

while(1) {
       100::ms => now;
}
 
