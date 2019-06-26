class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
      .4 => s.width;
        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  //
t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" {c
*2

!1!1!1_ 1_B!1
____ ____

" => t.seq;
2.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, 1., 40::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last;

STTREMOLO sttrem;
.3 => sttrem.mod.gain;  7 => sttrem.mod.freq;
sttrem.pa.set(2 * 100::ms , 0::ms , 1., 1700::ms);
sttrem.connect(last $ ST, t.note_info_tx_o);  sttrem  $ ST @=>  last;  

STSYNCWPDiodeLadder stsyncdl;
stsyncdl.freq(228 /* Base */, 6 * 100 /* Variable */, 1. /* resonance */ , true /* nonlinear */, true /* nlp_type */ );
stsyncdl.adsr_set(.1 /* Relative Attack */, .1/* Relative Decay */, .7 /* Sustain */, .4 /* Relative Sustain dur */, .5 /* Relative release */);
stsyncdl.connect(last $ ST, t.note_info_tx_o); stsyncdl $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
