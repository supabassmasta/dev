class synt0 extends SYNT{
    inlet => blackhole;

    BlowBotl bottle  => PowerADSR padsr =>  outlet; 
    padsr.set(4000::ms, 2000::ms, .7 , 4000::ms);
    padsr.setCurves(1. , 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    // ding!
    .09 => bottle.noiseGain;
    5 => bottle.vibratoFreq;
    .2 => bottle.vibratoGain;
    .8 => bottle.volume;

    fun void f1 (){ 
      1::samp => now;
      inlet.last() => bottle.freq;
       } 
       
        

        fun void on()  { padsr.keyOn();}  fun void off() { padsr.keyOff();}  fun void new_note(int idx)  {.8 => bottle.noteOn; spork ~ f1 ();} 1 => own_adsr;
}

TONE t;
t.reg(synt0 s1);
t.reg(synt0 s2);
t.reg(synt0 s3);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.aeo();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c :2 1|3|5 1|3|5  
       4|6|8  2|4|9 
       " => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 
STLPF lpf;
lpf.connect(last $ ST , 310/* freq */  , 1.2 /* Q */  );       lpf $ ST @=>  last; 

//STLPFC lpfc;
//lpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lpfc $ ST @=>  last; 

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

STREV2 rev; // DUCKED
rev.connect(last $ ST, .1 /* mix */);      rev $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
