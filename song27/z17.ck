class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*3 {c !8!6!7!5 !6!4!5!3 !4!2!3!1" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 9* 100.0 /* freq */ , 2.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
//stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 2 /* Q */, 3 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 
//SinOsc sin0 =>  OFFSET ofs0 =>  stfreelpfx0.freq; // CONNECT THIS 
//10 * 100 => ofs0.offset;
//1 => ofs0.gain;
//
//.2 => sin0.freq;
//800.0 => sin0.gain;

//STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
//stsynclpfx0.freq(100 /* Base */, 3 * 100 /* Variable */, 4. /* Q */);
//stsynclpfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
//stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => 
//SinOsc sin0 =>  OFFSET ofs0 =>  stsynclpfx0.nio.padsr; 
//24 * 100 => ofs0.offset;
//1 => ofs0.gain;

//.2 => sin0.freq;
//1800.0 => sin0.gain;


//STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
//stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 2.0 /* Q */, 2 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 3 /* order */, 1 /* channels */ , 1::samp /* update period */ );       stautolpfx0 $ ST @=>  last;  

//STFILTERXC stlpfxc_0; LPF_XFACTORY stlpfxc_0fact;
//stlpfxc_0.connect(last $ ST ,  stlpfxc_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 3 /* order */, 1 /* channels */);       stlpfxc_0 $ ST @=>  last;  

//STFILTERXC2 stlpfxc2_0; LPF_XFACTORY stlpfxc2_0fact;
//stlpfxc2_0.connect(last $ ST ,  stlpfxc2_0fact, HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */, 1 /* order */, 1 /* channels */, 10::ms /* ramp dur */, 1::ms /* update period */ );       stlpfxc2_0 $ ST @=>  last;  

//STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
//stbpfx0.connect(last $ ST ,  stbpfx0_fact, 5* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  

//STAUTOFILTERX stautobpfx0; BPF_XFACTORY stautobpfx0_fact;
//stautobpfx0.connect(last $ ST ,  stautobpfx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautobpfx0 $ ST @=>  last;  

STSYNCFILTERX stsynckgx0; KG_XFACTORY stsynckgx0_fact;
stsynckgx0.freq(100 /* Base */, 5 * 100 /* Variable */, 4. /* Q */);
stsynckgx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynckgx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynckgx0.connect(last $ ST ,  stsynckgx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynckgx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynckgx0.nio.padsr; 
SinOsc sin0 =>  OFFSET ofs0 =>  stsynckgx0.nio.padsr; 
36 * 100 => ofs0.offset;
1 => ofs0.gain;

.2 => sin0.freq;
1800.0 => sin0.gain;


STAUTOFILTERX stautodlx0; DL_XFACTORY stautodlx0_fact;
stautodlx0.connect(last $ ST ,  stautodlx0_fact, 1.0 /* Q */, 6 * 100 /* freq base */, 18 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautodlx0 $ ST @=>  last;  

4. => stautodlx0.gain;

while(1) {
       100::ms => now;
}
 
