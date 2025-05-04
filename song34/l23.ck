
TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //
10::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(130 /* synt nb */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
____ 111_ 1_1_1___
____ f11_ 1_1_1_8_
1111 111_ 1_1_1___
1_1_ 811_ 1_1_1_8_



" => t.seq;
.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(38 * 100 /* Base */, 43 * 100 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.2 /* Relative Attack */, .3/* Relative Decay */, 0.9 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 2.0 /* Q */, 5 * 100 /* freq base */, 40 * 100 /* freq var */, data.tick * 9 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  


133::ms => dur convrevin_dur;
// IR generation examples:
KIK kik;
kik.config(0.4 /* init Sin Phase */, 76 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (188, 1 * 10::ms);
kik.addFreqPoint (.0, convrevin_dur -10::ms);
kik.addGainPoint (0.2, 1 * 10::ms); 
kik.addGainPoint (0.0, convrevin_dur -10::ms); 
kik.outlet => Gain ir;
kik.new_note(0);

//Noise n => LPF lpf => Envelope e0 =>   ir;
//821 => lpf.freq;
//8 * 0.01 => e0.value;
//0.0 => e0.target;
//convrevin_dur => e0.duration ;// => now;

STCONVREVIN stconvrevin;
stconvrevin.connect(last $ ST , ir/*UGen Input Reponse*/ , convrevin_dur /*rev_dur*/, .1 /* rev gain */  , 0.0 /* dry gain */  );       stconvrevin $ ST @=>  last;   

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 18/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .07 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
