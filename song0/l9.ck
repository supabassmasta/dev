class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet;   
        .2 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;
t.reg(synt0 s1);

TONE t2;
t2.reg(synt0 s2);
t.element_sync();
t.aeo();
t2.aeo();
t2.element_sync();
//data.tick * 4=> t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();t.aeo(); t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}9}c}c *4 _1_4 _2__  _1_4 _2__  _1!6!4!6_2_5  _1_4 7!2!5_" => t.seq;
"}9}c}c *4 _1_4 _2__  _1_4 _2__  _1!6!4!6_2_5  _1_4 7!2!5" => t2.seq;
// t.mono() => dac; t.left() => dac.left; t.right() => dac.right; t.raw => dac;

t.mono() => Gain g => dac; //t.left() => dac.left; t.right() => dac.right; t.raw => dac;
g => Delay fb => g;
.5=> fb.gain;
data.tick /4 => fb.max => fb.delay;
g => Gain grev => global_mixer.rev0;
.5 => grev.gain;

t.adsr[0].set(2::ms, 20::ms, 0.00001, 0::ms);

t2.mono() => g;
t2.adsr[0].set(2::ms, 20::ms, 0.00001, 0::ms);

t.go(); 
t2.go(); 

while(1) {
       100::ms => now;
}
    
