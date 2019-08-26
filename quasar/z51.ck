class KS extends Chubgraph {
// Noise thru envelope through string into filter into dac
    Noise n => ADSR plk => DelayA strng => OneZero loop =>  outlet;
    loop => strng;                // hook delay back to itself
    second => strng.max;       // 50 Hz. is lowest frequency we expect
    (ms,10*ms,0.0,ms) => plk.set; // set noise envelope
    100.0 => float frq;   // default frequency
    10.0 => float sust; // in seconds
//    sustain(sust);
    second/frq => strng.delay;   // delay time is 1.0/freq seconds 

    plk.keyOff();
    0 => n.gain;
    0 => loop.gain;

    fun void pluck(float note, float vel)  {
        Std.mtof(note) => frq;
        ((second / samp) / frq - 1) => float period;
        (samp,period::samp,0.0,samp) => plk.set;
        period::samp => strng.delay;
        vel => n.gain;
        1 => plk.keyOn;
    }
    
    fun void sustain(float aT60)  {
        aT60 => sust;
        Math.exp(-6.91/sust/frq) => loop.gain;
    }    
}

class synt0 extends SYNT{
    0.1 => float velocity;
    4 => float sustain;

    inlet => blackhole;
    KS k =>  outlet; 
    .5 => k.gain;


    fun void on()  { }  fun void off() { } 
    fun void new_note(int idx)  { 
      1::samp => now;
      
      Std.ftom( inlet.last() ) => float note;

      if (note > 0) {
        k.sustain(sustain);
        k.pluck(note, velocity);
      }
    }
    
    1 => own_adsr;
} 


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c 
*4
1__1 _1__
5_5_ _5!5_
1__1 _1_1
__8_ 8!8!8_
" => t.seq;
4.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STLPF lpf;
lpf.connect(last $ ST , 2 * 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 3 /* Q */, 4 * 100 /* f_base */ , 16  * 100  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STLIMITER stlimiter;
7. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   

while(1) {
       100::ms => now;
}
 
