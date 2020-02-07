TONE t;
t.reg(SERUM0 s0); s0.config(6, 1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" :4

5___

" => t.seq;
3.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
4 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(10::ms, 30::ms, .8, 1400::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//////////// ADD DETUNE SYNT
SERUM0 s1; s1.config(6, 1);

s0.inlet => Gain detune => s1 => s0.outlet;
.3 => s1.gain;
1.007 => detune.gain;
//////////////////////////

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 3 * 100 /* Variable */, 2. /* Q */);
stsynclpf.adsr_set(.1 /* Relative Attack */, .3/* Relative Decay */, 0.6 /* Sustain */, .2 /* Relative Sustain dur */, 1.0 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STWPDiodeLadder stdl;
stdl.connect(last $ ST , 71 * 10 /* cutoff */  , 2. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 






while(1) {
       100::ms => now;
}
 
