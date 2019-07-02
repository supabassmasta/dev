class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 *2 
1_1_ __8_ __8_ 1_1_
1_1_ __5_ __0_ 1_1_
1_1_ __8!8__8_ 1_1_
1_8_ 3_5_ __8_ 1___

" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last;

STSYNCLPF stsynclpf;
stsynclpf.freq(3 * 100 /* Base */, 8 * 100 /* Variable */, 5. /* Q */);
stsynclpf.adsr_set(.01 /* Relative Attack */, .5/* Relative Decay */, .0001 /* Sustain */, .02 /* Relative Sustain dur */, 0.04 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .5 /* delay line gain */, 28 *  .1::ms /* dur base */, 19 * .1::ms /* dur range */, 1::second /( 16 * data.tick) /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .5 /* delay line gain */, 28 *  .1::ms /* dur base */, 19 * .1::ms /* dur range */, 1::second /( 17 * data.tick) /* freq */); 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .3 /* delay line gain */, 45 *  .1::ms /* dur base */, 11 * .1::ms /* dur range */, 1::second /( 6 * data.tick) /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .3 /* delay line gain */, 45 *  .1::ms /* dur base */, 11 * .1::ms /* dur range */, 1::second /( 7 * data.tick) /* freq */); 



STLIMITER stlimiter;
3. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
