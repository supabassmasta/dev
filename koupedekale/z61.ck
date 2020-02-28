class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
    .14 => s.width;
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
*8 }c 
 ____ ____ ____ ____ ____ ____ 5_7_ 7_2_  ____  ____  ____  ____  ____  ____  ____  ____ 
 ____ ____ ____ ____ ____ ____ 2_0_ 5_7_  ____  ____  ____  ____  ____  ____  ____  ____ 
 ____ ____ ____ ____ ____ __5_ __5_ 2_9_  ____  ____  ____  ____  ____  ____  ____  ____ 
 ____ ____ ____ ____ ____ ____ 9_5_ __7_  ____  ____  ____  ____  ____  ____  ____  ____ 
" => t.seq;
.25 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 11 * 100 /* Variable */, 1.8 /* Q */);
stsynclpf.adsr_set(.06 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 6 / 4 , .6);  ech $ ST @=>  last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .7 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 1 /* freq */); 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 6 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 
while(1) {
       100::ms => now;
}
 
