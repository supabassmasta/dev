class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
Step det_amount[synt_nb];
TriOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;
.1 => float w;
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; w => s[i].width;  i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -2.38 => det_amount[i].next;      .1 => s[i].gain; w => s[i].width;i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.32 => det_amount[i].next;      .1 => s[i].gain;w => s[i].width; i++;   

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


POLYTONE pt;

3 => pt.size;

// data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;//
1 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  

// /!\ Not managed for all TONE in POLY TONE
//pt.t[0].force_off_action();
// pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;

pt.dor();// pt.lyd();// pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
//pt.sync(4*data.tick);// pt.element_sync();//  pt.no_sync();//  pt.full_sync();

.06 * data.master_gain =>  pt.gain_common;
// .6 * data.master_gain => pt.t[0].gain; // For individual gain

pt.t[0].reg(synt0 s0); 
pt.t[0].reg(synt0 s01); 
pt.t[0].reg(synt0 s02); 
pt.t[0].reg(synt0 s04); 
pt.t[1].reg(synt0 s1); 
pt.t[1].reg(synt0 s12); 
pt.t[1].reg(synt0 s13); 
pt.t[1].reg(synt0 s14); 
pt.t[2].reg(synt0 s2); 

2*data.tick => dur a;
6*data.tick => dur r;
 pt.t[0].adsr[0].set(a, 10::ms, 1., r);
 pt.t[0].adsr[1].set(a, 10::ms, 1., r);
 pt.t[0].adsr[2].set(a, 10::ms, 1., r);
 pt.t[0].adsr[3].set(a, 10::ms, 1., r);

 pt.t[1].adsr[0].set(a, 10::ms, 1., r);
 pt.t[1].adsr[1].set(a, 10::ms, 1., r);
 pt.t[1].adsr[2].set(a, 10::ms, 1., r);
 pt.t[1].adsr[3].set(a, 10::ms, 1., r);

// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c :8 1|3|5|6_3|6|8|c_" +=> pt.tseq[0];
"}c :8 _B|0|2|4__ ___0|2|5|7" +=> pt.tseq[1];
"_" +=> pt.tseq[2];

pt.go();

// CONNECTIONS
pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
// pt.t[0] $ ST @=> ST @ last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 6 /* freq */); 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 1400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .4 /* mix */, 9 * 10. /* room size */, 6::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
