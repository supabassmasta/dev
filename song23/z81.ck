class STFLANGER extends ST{
  1::samp => dur period;

 Gain fbl => outl;

 Gain fbr => outr;

  fun void connect(ST @ tone) {
    tone.left() => fbl;
    tone.right() => fbr;

  }
  
  fun void control(Delay @ d, dur base,  dur range, float freq){
    SinOsc s => blackhole;

    freq => s.freq;

    while(1) {
      base + s.last() * range / 2. => d.delay; 
      period => now;
    }
     
  }


  fun void add_line(int left_right_both /* 0 : left, 1: right 2: both */, float g, dur base, dur range, float freq) {

    new Delay @=> Delay @ d;
    base + range/2. => d.max;
    base => d.delay;
    g => d.gain;

    if ( range != 0::ms  ){
      spork ~ control(d, base, range, freq);
    }

    if ( left_right_both == 0 || left_right_both == 2 ){
      fbl => d => fbl;
    }
    else {
      fbr => d => fbr;
    }

    if ( left_right_both == 2   ){
      add_line(1 /* right */, g, base, range, freq);
    }


  }
}


class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(SUPERSAW0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c
*4
!1////8
!1////8
!1////8
!1////8

33!22" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//
STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  6::ms /* dur base */, 1::ms /* dur range */, 91 /* freq */);
//flang.add_line(1 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  2.05::ms /* dur base */, 1.05::ms /* dur range */, 2.01 /* freq */);
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .3 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */);
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .4 /* delay line gain */,  4::ms /* dur base */, 2::ms /* dur range */, 2 /* freq */);

//STFILTERMOD fmod;
//fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 400  /* f_var */, 1::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last;


STSYNCLPF stsynclpf;
stsynclpf.freq(3 * 100 /* Base */, 7 * 100 /* Variable */, 4. /* Q */);
stsynclpf.adsr_set(.4 /* Relative Attack */, 1.9/* Relative Decay */, 0.7 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

//STLIMITER stlimiter;
//1. => float in_gainl;
//stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
