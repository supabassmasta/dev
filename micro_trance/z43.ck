

TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(1234 /* synt nb */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c 
*8 1_1_1___1_1___1_ :8 
*8 3_3_1___1_1___1_ :8 
*8 3_3_1___1_1___1_ :8 
*8 3_1_3___3_1___1_ :8 
" => t.seq;
1.50 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STQSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(10 * 10 /* Base */, 27 * 100 /* Variable */, 2.5 /* Q */);
stsynclpfx0.adsr_set(.02 /* Relative Attack */, .3/* Relative Decay */, 0.8 /* Sustain */, .4 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 1.4 /* Q */, 4 * 100 /* freq base */, 28 * 100 /* freq var */, data.tick * 24 / 2 /* modulation period */, 2 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

//STFILTERX stbrfx0; BRF_XFACTORY stbrfx0_fact;
//stbrfx0.connect(last $ ST ,  stbrfx0_fact, 85.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stbrfx0 $ ST @=>  last;  

STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
sthpfx0.connect(last $ ST ,  sthpfx0_fact,  140.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

//STGAINC gainc;
//gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 3. /* static gain */  );       gainc $ ST @=>  last; 

//STFADEIN fadein;
//fadein.connect(last, 24*data.tick);     fadein  $ ST @=>  last; 

// mod
SinOsc sin0 =>  s0.inlet;
93.0 => sin0.freq;
17.0 => sin0.gain;



while(1) {
       100::ms => now;
}
 
