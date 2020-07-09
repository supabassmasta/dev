class synt0 extends SYNT{


  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  Step det_amount[synt_nb];
  SinOsc s[synt_nb];
  Gain final => outlet; .6 => final.gain;

  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  5.51 => det_amount[i].next;      .1 => s[i].gain; i++;   


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


POLYTONE pt;

4 => pt.size;

// data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;//
4 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  

// /!\ Not managed for all TONE in POLY TONE
//pt.t[0].force_off_action();
// pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;

pt.dor();// pt.lyd();// pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
//pt.sync(4*data.tick);// pt.element_sync();//  pt.no_sync();//  pt.full_sync();

.6 * data.master_gain =>  pt.gain_common;
 2.6 * data.master_gain => pt.t[2].gain; // For individual gain
 1.6 * data.master_gain => pt.t[3].gain; // For individual gain

pt.t[0].reg(synt0 s0); 
pt.t[1].reg(synt0 s1); 
pt.t[2].reg(CELLO1 s2); 
pt.t[3].reg(CELLO1 s3); 

pt.adsr0_set(1500::ms, 1000::ms, .8, 3000::ms); // Only works for ADSR 0
pt.adsr0_setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 111/88/1" +=> pt.tseq[0];
 
 ":4}c11/{c11/}c11" +=> pt.tseq[1];
 "11/{c11/}c11" +=> pt.tseq[1];
 "1/{c11/{c11/}c11" +=> pt.tseq[1];
 "11/{c11/}c11/}c1" +=> pt.tseq[1];

":4 111_ ____" +=> pt.tseq[2];
":4 ____ 88__" +=> pt.tseq[3];

pt.go();

// CONNECTIONS
//pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
 pt.t[0] $ ST @=> ST @ last; 
 pt.t[1] $ ST @=>  last; 
 pt.t[2] $ ST @=>  last; 
 pt.t[3] $ ST @=>  last; 

STGAIN stgain2;
stgain2.connect(last $ ST , 1. /* static gain */  );       stgain2 $ ST @=>  last; 
stgain2.connect(pt.t[2] $ ST , 1. /* static gain */  );       stgain2 $ ST @=>  last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, .15 /* freq */); 


STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(pt.t[0] $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

stgain.connect(pt.t[1] $ ST , .8 /* static gain */  );       stgain $ ST @=>  last; 


STGVERB stgverb;
stgverb.connect(last $ ST, .3 /* mix */, 7 * 10. /* room size */, 3::second /* rev time */, 0.3 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
