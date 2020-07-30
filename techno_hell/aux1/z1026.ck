class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SinOsc s[synt_nb];
Gain final => outlet; .8 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => TriOsc s2 => final;    1. => detune[i].gain;  .3 => s2.width;  .2 => s2.gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //
1.5 * data.tick => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *3
}c}c
15320


" => t.seq;
.17 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 1200  /* f_var */, 1::second / (8 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STCUTTER stcutter;
":8:2 _11_11" => stcutter.t.seq;
stcutter.connect(last,8 *data.tick /* attack */, 8 *data.tick /* release */ );   stcutter $ ST @=> last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .3 /* mix */, 13 * 10. /* room size */, 8::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

STDUCK2 duck2;
duck2.connect(last $ ST, 1. /* Side Chain Gain */, .04 /* Tresh */, .5 /* Slope */, 9::ms /* Attack */, 40::ms /* Release */ );      duck2 $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
