

TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//s0.config(1234 /* synt nb */ ); 
s0.config(1232/* synt nb */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//*8 1_1_1___1_1___1_ :8 
" 
*8 1_1_1___ 8_1_ ____ :8 
*8 1_1_1___ 1_1_ __8_ :8 
" => t.seq;
0.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STQSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(25 * 10 /* Base */, 15 * 100 /* Variable */);
stsynclpfx0.q(1 /* Base */, 8 /* Variable */);
stsynclpfx0.adsr_set(.02 /* Relative Attack */, .3/* Relative Decay */, 0.8 /* Sustain */, .4 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.q_adsr_set(.1 /* Relative Attack */, 0.8/* Relative Decay */, 0.0 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

1::samp => stsynclpfx0.nio.period;
//10::ms => stsynclpfx0.nio.period;

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, .03 /* mix */); strevaux $ ST @=>  last;  

//STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
//stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 1.4 /* Q */, 4 * 100 /* freq base */, 28 * 100 /* freq var */, data.tick * 24 / 2 /* modulation period */, 2 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

//STFILTERX stbrfx0; BRF_XFACTORY stbrfx0_fact;
//stbrfx0.connect(last $ ST ,  stbrfx0_fact, 85.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stbrfx0 $ ST @=>  last;  

//STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//sthpfx0.connect(last $ ST ,  sthpfx0_fact,  140.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

//STGAINC gainc;
//gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 3. /* static gain */  );       gainc $ ST @=>  last; 

//STFADEIN fadein;
//fadein.connect(last, 24*data.tick);     fadein  $ ST @=>  last; 

// mod
//SinOsc sin0 =>  s0.inlet;
//114.0 => sin0.freq;
//14.0 => sin0.gain;

STEPC stepc; stepc.init(HW.lpd8.potar[1][2], 0 /* min */, 8 * 1000 /* max */, 50::ms /* transition_dur */);
stepc.out =>  stsynclpfx0.nio.padsr;

STEPC stepc2; stepc2.init(HW.lpd8.potar[1][3], 0 /* min */, 20 /* max */, 50::ms /* transition_dur */);
stepc2.out =>  stsynclpfx0.nio.q_padsr;

STEPC stepc3; stepc3.init(HW.lpd8.potar[1][4], 0 /* min */, 20 * 100 /* max */, 50::ms /* transition_dur */);
stepc3.out =>  stsynclpfx0.nio.filter_freq;

<<<"<[-]><[-]><[-]><[-]><[-]><[-]><[-]><[-]><[-]><[-]><[-]>">>>;
<<<"<[-]>                 !!!  ACID !!!               <[-]>">>>;
<<<"<[-]>  lpd8 1.1 gain                              <[-]>">>>;
<<<"<[-]>  lpd8 1.2 target freq (beware low freq)     <[-]>">>>;
<<<"<[-]>  lpd8 1.3 target Q (min==1)                 <[-]>">>>;
<<<"<[-]>  lpd8 1.4 Base Freq                 <[-]>">>>;
<<<"<[-]><[-]><[-]><[-]><[-]><[-]><[-]><[-]><[-]><[-]><[-]>">>>;



while(1) {
       100::ms => now;
}
 
