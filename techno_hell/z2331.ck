TONE t;
t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.add(6 /* synt nb */ , 0 /* rank */ , 0.3 /* GAIN */, 1.0 /* in freq gain */,  2::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
//s0.add(1 /* synt nb */ , 0 /* rank */ , 0.15 /* GAIN */, 1.0 /* in freq gain */,  2::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
// s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
}c

1_1_ 11__ 1__8 ____ 
*2 1_1_1_1_ :2 ____ ____ ____

" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(100 /* Base */, 59 * 100 /* Variable */, 1.5 /* Q */);
stsynclpfx0.adsr_set(.1 /* Relative Attack */, .7/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     
//
//SinOsc sin1 =>  OFFSET ofs0 =>  stsynclpfx0.nio.padsr; 
//20 * 100. => ofs0.offset;
//1. => ofs0.gain;

//0.1 => sin1.freq;
//14 * 100.0 => sin1.gain;


ADSRMOD2 adsrmod; // Freq input modulation with external input and ADSR
adsrmod.adsr_set(0.01 /* relative attack dur */, 0.4 /* relative decay dur */ , 0.001 /* sustain */, - 0.5 /* relative sustain pos */, .3 /* relative sustain dur */);
adsrmod.padsr.setCurves(1., 3., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 
TriOsc sin0   => adsrmod.in; // CONNECT this /!\ WARNING Modulator Gain to set as ratio of main frequeny example 0.1 
52.0 => sin0.freq;
0.10 => sin0.gain;
.3 => sin0.width;

STAUTOFILTERX stautohpfx0; HPF_XFACTORY stautohpfx0_fact;
stautohpfx0.connect(last $ ST ,  stautohpfx0_fact, 2.4 /* Q */, 1 * 100 /* freq base */, 9 * 100 /* freq var */, data.tick * 43 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautohpfx0 $ ST @=>  last;  

STGVERB stgverb;
stgverb.connect(last $ ST, 1. /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 5* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
//stbpfx0.connect(last $ ST ,  stbpfx0_fact, 5* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
//2 => stbpfx0.gain;

STGAIN stgain;
stgain.connect(stautohpfx0 $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
