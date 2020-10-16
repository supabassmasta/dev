class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;

TriOsc tri0 =>  s;
29.0 => tri0.freq;
2.0 => tri0.gain;
0.8 => tri0.width;


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 



TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
{c
!1_1_ __3_ _0__
1!0!1_ __3_ _0_1

" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 



STSYNCFILTERX stfilter; LPF_XFACTORY stfilterfactory;
stfilter.freq(100 /* Base */, 55 * 100 /* Variable */, 5. /* Q */);
stfilter.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stfilter.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stfilter.connect(last $ ST ,  stfilterfactory, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stfilter $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
