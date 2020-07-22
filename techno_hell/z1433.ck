TONE t;
t.reg(CELLO2 s0);
t.reg(CELLO2 s1);
t.reg(CELLO2 s2);


//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4:2 1|3|5//// //// 1|3|5 ____" => t.seq;
.4 * data.master_gain => t.gain;
t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(1000::ms, 10::ms, 1, 2000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(1000::ms, 10::ms, 1, 2000::ms);
t.adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[2].set(1000::ms, 10::ms, 1, 2000::ms);
t.adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  8::ms /* dur base */, 1::ms /* dur range */, .2 /* freq */); 


STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 100 * 100 /* Variable */, 1.10 /* Q */);
stsynclpf.adsr_set(1. /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .02 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpf.nio.padsr.setCurves(2, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
