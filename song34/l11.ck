class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      1. => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{2 *4
__1!1 __1!1 __1//1 __1_ 
__1!1 __1!1 __5//1 __1_ 
__1!1 __1!1 __1//1 __1_ 
__1!1 __1!1 __8//1 __1_ 

" => string seq;
seq => t.seq;
//"{c{2 *2 _1" => t.seq;
.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(199::ms, 10::ms, .7, 400::ms);
t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STCONVREV stconvrev;
stconvrev.connect(last $ ST , 56/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, 1. /* rev gain */  , 0.0 /* dry gain */  );       stconvrev $ ST @=>  last;  

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(100 /* Base */, 4 * 100 /* Variable */, 1.1 /* Q */);
stsynclpfx0.adsr_set(.03 /* Relative Attack */, .6/* Relative Decay */, 0.6 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STCUTTER stcutter;
seq => stcutter.t.seq;
stcutter.connect(last, 1::ms /* attack */, 126::ms /* release */ );   stcutter $ ST @=> last; 

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 

