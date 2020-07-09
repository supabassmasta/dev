class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

class synt1 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

      SawOsc mod => OFFSET o => s;
      23 => mod.freq;
      20 => o.offset;
      40 => o.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

class synt2 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .1 => s.gain;
      .1 => s.width;
      SawOsc mod => OFFSET o => MULT m => s;
      16 => mod.freq;
      10 => o.offset;
      30 => o.gain;

      SinOsc mod2 => OFFSET o2 => m;
      .1 => mod2.freq;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

POLYTONE pt;

3 => pt.size;

// data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;// 1 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  

// /!\ Not managed for all TONE in POLY TONE
//pt.t[0].force_off_action();
// pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;

pt.dor();// pt.lyd();// pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
//pt.sync(4*data.tick);// pt.element_sync();//  pt.no_sync();//  pt.full_sync();

.4 * data.master_gain =>  pt.gain_common;
 .7 * data.master_gain => pt.t[0].gain; // For individual gain
 .7 * data.master_gain => pt.t[2].gain; // For individual gain

pt.t[0].reg(synt0 s0); 
pt.t[1].reg(synt1 s1); 
pt.t[2].reg(synt2 s2); 

pt.adsr0_set(5::ms, 1::ms, 1, 3::ms); // Only works for ADSR 0
pt.adsr0_setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c " +=> pt.tseq[0];
"*4 " +=> pt.tseq[1];
"*4 " +=> pt.tseq[2];

"1__1 __1_ _1__ 1_1_" +=> pt.tseq[0];
"____ ____ ____ ___1" +=> pt.tseq[1];
"__1_ __1_ ___1 1_1_" +=> pt.tseq[2];

"1__1 __1_ _1__ 1___" +=> pt.tseq[0];
"____ ____ ____ ___3" +=> pt.tseq[1];
"__1_ _1!1_ __1_ _1 !1_" +=> pt.tseq[2];

//"____ ____ ____ ____" +=> pt.tseq[0];
//"____ ____ ____ ____" +=> pt.tseq[1];
//"____ ____ ____ ____" +=> pt.tseq[2];

//"____ ____ ____ ____" +=> pt.tseq[0];
//"____ ____ ____ ____" +=> pt.tseq[1];
//"__1_ " +=> pt.tseq[2];

pt.go();

// CONNECTIONS
//pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
 pt.t[0] $ ST @=> ST @ last; 
 pt.t[1] $ ST @=>  last; 

 pt.t[2] $ ST @=>  last; 


STSYNCLPF2 stsynclpf2;
stsynclpf2.freq(100 /* Base */, 28 * 100 /* Variable */, 2.0 /* Q */);
stsynclpf2.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.0001 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpf2.nio.padsr.setCurves(1.0, 0.6, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpf2.connect(last $ ST, pt.t[2].note_info_tx_o); stsynclpf2 $ ST @=>  last; 


STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 3 /* Q */, 60*10 /* f_base */ , 2400  /* f_var */, 1::second / (33 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(pt.t[0] $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(pt.t[1] $ ST , .7 /* static gain */  );       stgain $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .007 /* mix */, 11 * 10. /* room size */, 7::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
