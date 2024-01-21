class synt0 extends SYNT{

    8 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    SawOsc s[synt_nb];
    Gain final => outlet; .7 => final.gain;

    inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; i++;  
//    inlet => detune[i] => s[i] => final;    2.001 => detune[i].gain;    .2 => s[i].gain; i++;  

//    inlet => SawOsc s =>  outlet; 
//      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 
TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2 {c_1" => t.seq;
.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STQSYNCFILTERX stqsynclpfx0; LPF_XFACTORY stqsynclpfx0_fact;
stqsynclpfx0.freq(12 * 10 /* Base */, 25 * 10 /* Variable */);
stqsynclpfx0.q(1 /* Base */, 3 /* Variable */);
stqsynclpfx0.adsr_set(.3 /* Relative Attack */, .3/* Relative Decay */, 0.6 /* Sustain */, .3 /* Relative Sustain dur */, 0.2 /* Relative release */);
stqsynclpfx0.q_adsr_set(.2 /* Relative Attack */, 0.7/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stqsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stqsynclpfx0.connect(last $ ST ,  stqsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::samp /* period */ );       stqsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on targets //     => stqsynclpfx0.nio.padsr; // =>  stqsynclpfx0.nio.filter_freq //  =>  stqsynclpfx0.nio.q_padsr; 

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); //
SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"l" => s.seq;
1.4 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate; // s.out("k") /* return ST */
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> last; 

while(1) {
       100::ms => now;
}
 
