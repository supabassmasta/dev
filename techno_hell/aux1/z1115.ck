class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SinOsc s[synt_nb];
Gain final => outlet; .5 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    2. => detune[i].gain;    .3 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
}


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4

____ ____ ____ ____  ___1 ___5 _1__ 1_1_ 
____ ____ ____ ____  ___1 ___5 _1__ 3_1_ 
____ ____ ____ ____  _*2 1_1_:21 ___5 _1__ 1_1_ 
____ ____ ____ ____  ___1 ___5 _1__ 3_1_ 

" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(10::ms, 10::ms, 1., 40::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ADSRMOD adsrmod;
adsrmod.adsr_set(0.1 /* relative attack dur */, 0.000001 /* relative decay dur */ , 1.0 /* sustain */, - 0.2 /* relative sustain pos */, .3 /* relative sustain dur */);
adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 

while(1) {
       100::ms => now;
}
 
