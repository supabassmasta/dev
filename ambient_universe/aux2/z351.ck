class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
Step det_amount[synt_nb];
SERUM0 s[synt_nb];
Gain final => outlet; .3 => final.gain;

49 =>int  nb;
0 => int rk;

inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  -4.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  4.51 => det_amount[i].next;      .1 => s[i].gain; i++;   

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

class synt1 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
Step det_amount[synt_nb];
SERUM0 s[synt_nb];
Gain final => outlet; .3 => final.gain;

48 =>int  nb;
0 => int rk;

inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  -4.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  4.51 => det_amount[i].next;      .1 => s[i].gain; i++;   

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


TONE t[3];
0 => int id;
ST @ last;


t[id].reg(synt0 s0);  
t[id].reg(synt0 s1); .8 => s1.outlet.gain; 
t[id].reg(synt0 s2); .7 => s1.outlet.gain; 
t[id].reg(synt0 s3); .6 => s1.outlet.gain;  
//data.tick * 8 => t[id].max; //60::ms => t[id].glide;  // t[id].lyd(); // t[id].ion(); // t[id].mix();//
t[id].double_harmonic();// t[id].aeo(); // t[id].phr();// t[id].loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c}c:4
1|3|5___ {c 4|6|8___
" => t[id].seq;
.9 * data.master_gain => t[id].gain;
//t[id].sync(4*data.tick);// t[id].element_sync();//  t[id].no_sync();//  t[id].full_sync(); // 1 * data.tick => t[id].the_end.fixed_end_dur;  // 16 * data.tick => t[id].extra_end;   //t[id].print(); //t[id].force_off_action();
// t[id].mono() => dac;//  t[id].left() => dac.left; // t[id].right() => dac.right; // t[id].raw => dac;
t[id].adsr[0].set(2000::ms, 1000::ms, .8, 4000::ms);
t[id].adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].adsr[1].set(2000::ms, 1000::ms, .8, 4000::ms);
t[id].adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].adsr[2].set(2000::ms, 1000::ms, .8, 4000::ms);
t[id].adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].adsr[3].set(2000::ms, 1000::ms, .8, 4000::ms);
t[id].adsr[3].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].go();   t[id] $ ST @=>  last; 
.6 => t[id].outl.gain;
1. => t[id].outr.gain;
1 +=> id; 

STSYNCLPF2 stsynclpf2;
stsynclpf2.freq(40 *10 /* Base */, 70 * 100 /* Variable */, 2.0 /* Q */);
stsynclpf2.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf2.connect(last $ ST, t[0].note_info_tx_o); stsynclpf2 $ ST @=>  last; 


t[id].reg(synt1 S0);  
t[id].reg(synt1 S1); .8 => s1.outlet.gain; 
t[id].reg(synt1 S2); .7 => s1.outlet.gain; 
t[id].reg(synt1 S3); .6 => s1.outlet.gain;  
//data.tick * 8 => t[id].max; //60::ms => t[id].glide;  // t[id].lyd(); // t[id].ion(); // t[id].mix();//
t[id].double_harmonic();// t[id].aeo(); // t[id].phr();// t[id].loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c}c:4
__0|2|4_ {c __5|7|9_
" => t[id].seq;
.9 * data.master_gain => t[id].gain;
//t[id].sync(4*data.tick);// t[id].element_sync();//  t[id].no_sync();//  t[id].full_sync(); // 1 * data.tick => t[id].the_end.fixed_end_dur;  // 16 * data.tick => t[id].extra_end;   //t[id].print(); //t[id].force_off_action();
// t[id].mono() => dac;//  t[id].left() => dac.left; // t[id].right() => dac.right; // t[id].raw => dac;
t[id].adsr[0].set(2000::ms, 1000::ms, .8, 4 * data.tick);
t[id].adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].adsr[1].set(2000::ms, 1000::ms, .8, 4 * data.tick);
t[id].adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].adsr[2].set(2000::ms, 1000::ms, .8, 4 * data.tick);
t[id].adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].adsr[3].set(2000::ms, 1000::ms, .8, 4 * data.tick);
t[id].adsr[3].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t[id].go();   t[id] $ ST @=>  last; 
1 => t[id].outl.gain;
0.6 => t[id].outr.gain;

1 +=> id; 

STSYNCLPF2 stsynclpf22;
stsynclpf22.freq(40 *10 /* Base */, 70 * 100 /* Variable */, 2.0 /* Q */);
stsynclpf22.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf22.connect(last $ ST, t[1].note_info_tx_o); stsynclpf22 $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(stsynclpf2 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STREC strec;
strec.connect(last $ ST, 32*data.tick, "../../_SAMPLES/ambient_universe/amb6.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); strec $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 




