class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
TriOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.001 => detune[i].gain;    .3 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.002 => detune[i].gain;    .3 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  //
t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" 

11__ 
5___ 
BB__ 
22__ 

11__ 
5___ 
8___ 
BB__ 
" => t.seq;
4.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
6 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(200::ms, 400::ms, .4, 2000::ms);
t.adsr[0].setCurves(1.2, 0.8, 0.9); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STWPDiodeLadder stdl;
stdl.connect(last $ ST , 7 * 100 /* cutoff */  , 1. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 

STTREMOLO sttrem;
.2 => sttrem.mod.gain;  5 => sttrem.mod.freq;
sttrem.pa.set(300::ms , 0::ms , 1., 1700::ms);
sttrem.connect(last $ ST, t.note_info_tx_o);  sttrem  $ ST @=>  last;  

//STFILTERMOD fmod;
//fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 400 /* f_base */ , 200  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .06 /* mix */, 8 * 10. /* room size */, 8::second /* rev time */, 0.1 /* early */ , 0.3 /* tail */ ); stgverb $ ST @=>  last; 





while(1) {
       100::ms => now;
}
 


