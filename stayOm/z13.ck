TONE t;
t.reg(SUPERSAW0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2 {c
_1__ __1_
__1_ _#4__
_1_1 __1_
__1_ _A__

_1__ __1_
__1_ _#4_*2 #4!#4 :2
_1_1 __1_
__1_ _*2 A!A!A!A!A!A :2
" => t.seq;
.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

DETUNE detune;
detune.base_synt(s0 /* base synt, controlling others */);
detune.reg_aux(SUPERSAW0 aux1); /* declare and register aux here */
detune.config_aux(2.00 /* detune percentage */, .5 /* aux gain output */ );  

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 2::ms /* dur range */, 74 /* freq */); 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 7 * 100 /* Variable */, 3. /* Q */);
stsynclpf.adsr_set(.3 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .1 /* Relative Sustain dur */, 0.5 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 , .1);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
