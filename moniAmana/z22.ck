class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
TriOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final; .1 => s[i].width;   1. => detune[i].gain;    .9 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; .1 => s[i].width;   1.01 => detune[i].gain;    .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; .1 => s[i].width;   2.00 => detune[i].gain;    .3 => s[i].gain; i++;  


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
}

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.lyd();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*3 {c {c ___ 1!1!1 ___ 5!1!1 " => t.seq;
3.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(10 /* Base */, 7 * 100 /* Variable */, 2. /* Q */);
stsynclpf.adsr_set(.5 /* Relative Attack */, .4/* Relative Decay */, 0.00000000000009 /* Sustain */, .001 /* Relative Sustain dur */, 0.000001 /* Relative release */);
stsynclpf.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
