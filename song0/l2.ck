class synt0 extends SYNT{

    inlet => SinOsc s =>ABSaturator sat =>  outlet;   
        .1 => s.gain;

26 => sat.drive;
4 => sat.dcOffset;


    SinOsc mod => s;
    4 => mod.gain;
    7 => mod.freq;

    SinOsc mod0 => s;
    4 => mod0.gain;
    10 => mod0.freq;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t; t.aeo(); 
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}9 1__1" => t.seq;
" 1__5" => t.seq;
" 5__4" => t.seq;
" 4__1" => t.seq;
 t.element_sync();// t.no_sync(); t.full_sync();     //t.print();

t.mono() => Gain g => dac; //t.left() => dac.left; t.right() => dac.right; t.raw => dac;
g => Gain grev => global_mixer.rev0;
.5 => grev.gain;
//t.mono() => blackhole;


t.go(); 

while(1) {
       100::ms => now;
}
    
