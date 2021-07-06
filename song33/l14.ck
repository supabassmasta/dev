TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(1339 /* synt nb */ ); 

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 __!1!1" => t.seq;
1.1 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(2::ms, 10::ms, .8, 4::ms);
t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(81 /* Base */, 7 * 100 /* Variable */, 2. /* Q */);
stsynclpf.adsr_set(.04 /* Relative Attack */, .3/* Relative Decay */, 0.4 /* Sustain */, .5 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpf.nio.padsr.setCurves(1.0, 0.7, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 34* 10.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


while(1) {
       100::ms => now;
}
 
