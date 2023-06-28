class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SawOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;
SinOsc sub ;
inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .9 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.007 => detune[i].gain;    .5 => s[i].gain; i++;  
//inlet => detune[i] =>  sub => final;    .5 => detune[i].gain;    1.3 => s[i].gain; i++;  
//    inlet => SawOsc s =>  outlet; 
//      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.6 => s[0].phase  ; 0.46 => s[1].phase  ; .5 => sub.phase; } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c *2 _!1_ _!1 _ _!1 _!1_ _!1 _ _*2!1!1" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::ms, 10::ms, 1, 32 * 10::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(15 * 10 /* Base */, 9 * 100 /* Variable */, 1.3 /* Q */);
stsynclpfx0.adsr_set(.3 /* Relative Attack */, .2/* Relative Decay */, 0.5 /* Sustain */, .3 /* Relative Sustain dur */, 0.5 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STGVERB stgverb;
stgverb.connect(last $ ST, .02 /* mix */, 1 * 10. /* room size */, 18 * 10::ms /* rev time */, 0.1 /* early */ , 0.4 /* tail */ ); stgverb $ ST @=>  last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 11* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  



while(1) {
       100::ms => now;
}
 
