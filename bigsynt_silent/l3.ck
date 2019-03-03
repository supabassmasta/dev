class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SqrOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    .000091 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    .000082 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    .000073 => detune[i].gain;    .3 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.000014 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.000023 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.000032 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.000041 => detune[i].gain;    .3 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(SUPERSAW0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s2); 
t.reg(synt0 s3); 
t.reg(synt0 s4); 
t.reg(synt0 s5); 
t.reg(synt0 s6); 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":8:2 {c 
1|3|5|8|b|d_
" => t.seq;
3.0 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[1].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[2].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[3].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[4].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[5].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCWPDiodeLadder stsyncdl;
stsyncdl.freq(13*100 /* Base */, 10 * 100 /* Variable */, 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */ );
stsyncdl.adsr_set(.3 /* Relative Attack */, .3/* Relative Decay */, 0.7 /* Sustain */, .2 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsyncdl.connect(t $ ST, t.note_info_tx_o); stsyncdl $ ST @=>  last;  

//STSYNCLPF stsynclpf;
//stsynclpf.freq(3*100 /* Base */, 6 * 100 /* Variable */, 6. /* Q */);
//stsynclpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
//stsynclpf.connect(t $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

//STREV2 rev; // DUCKED
//rev.connect(last $ ST, .3 /* mix */);      rev $ ST @=>  last; 

// WAIT seq to start
10::ms => now;

REC rec;
//rec.rec(8*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */);
rec.rec_no_sync(32*data.tick, "test.wav"); 


//4 *  data.tick => now;

