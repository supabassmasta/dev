class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .8 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 
          .5 => s.phase;
          } 0 => own_adsr;
}

144 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4{c {c *3  ___!11_!11_!11_" => t.seq;
1.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::samp, data.tick *1/16, .7, data.tick *1/16);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(17 * 10 /* Base */, 38 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.01 /* Relative Attack */, .27/* Relative Decay */, 0.6 /* Sustain */, .5 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 0.1, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STCOMPRESSOR stcomp;
//7. => float in_gain;
//stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   
//2.1 => stcomp.gain;

STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
stbpfx0.connect(last $ ST ,  stbpfx0_fact, 12* 10.0 /* freq */ , 2.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
0.40 => stbpfx0.gain;
//0.0 => stbpfx0.gain;

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(stsynclpfx0 , 1. /* static gain */  );       stgain $ ST @=>  last; 

STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
sthpfx0.connect(last $ ST ,  sthpfx0_fact, 35.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

//STREC strec;
//strec.connect(last $ ST, 8*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); strec $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
