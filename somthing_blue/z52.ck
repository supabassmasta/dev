class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SqrOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.13 => detune[i].gain;    .04 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// 
t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2 {c
8//1 11 11/66//4
444!4/2 222_

" => t.seq;
3.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STSYNCLPF stsynclpf;
//stsynclpf.freq(100 /* Base */, 3 * 100 /* Variable */, 4. /* Q */);
//stsynclpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
//stsynclpf.connect(t $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STSYNCWPDiodeLadder stsyncdl;
stsyncdl.freq(3*100 /* Base */, 5 * 100 /* Variable */, 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */ );
stsyncdl.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsyncdl.connect(t $ ST, t.note_info_tx_o); stsyncdl $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
