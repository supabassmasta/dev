class synt0 extends SYNT{
    inlet => blackhole;

    BlowBotl bottle  => PowerADSR padsr =>  outlet; 
    padsr.set(1000::ms, 2000::ms, .7 , 2000::ms);
    padsr.setCurves(1. , 1., 1.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    // ding!
    .0 => bottle.noiseGain;
    10 => bottle.vibratoFreq;
    150 => bottle.vibratoGain;
    .8 => bottle.volume;

    fun void f1 (){ 
      1::samp => now;
      inlet.last() => bottle.freq;
       } 
       
        

        fun void on()  { padsr.keyOn();.8 => bottle.noteOn; spork ~ f1 ();}  fun void off() { padsr.keyOff();}  fun void new_note(int idx)  {} 1 => own_adsr;
}

TONE t;
t.reg(synt0 s1);
t.reg(synt0 s2);
t.reg(synt0 s3);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // 
t.dor(); // t.mix();//
//t.aeo();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
}c 
1|31|31|3_
____
" => t.seq;
.30 * data.master_gain => t.gain;
1.4 => s1.bottle.gain;
0.6 => s2.bottle.gain;
s1.padsr.set(1000::ms, 2000::ms, .7 , 2000::ms);
s2.padsr.set(2000::ms, 2000::ms, .7 , 2000::ms);
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 
//STLPF lpf;
//lpf.connect(last $ ST , 510/* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

//STLPFC lpfc;
//lpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lpfc $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 100 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STREV1 rev; // DUCKED
rev.connect(last $ ST, .1 /* mix */);      rev $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
