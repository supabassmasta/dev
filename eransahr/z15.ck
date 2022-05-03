class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;
      .1 => s.width;
 
SinOsc mod => MULT m => s;
39 => mod.freq;
5 => mod.gain;

SinOsc g => OFFSET o => m;
.2 => g.freq;
.4 => o.gain;
.1 => o.offset;

STEPC stepc; stepc.init(HW.lpd8.potar[1][3], 0 /* min */, 3 /* max */, 50::ms /* transition_dur */);
stepc.out =>  m;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //
29::ms => t.glide;  // t.lyd(); // 
t.ion(); // t.mix();//
//t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
}c
10321032
1A231A23
10321032
1A2A2313
10321032
1A231A23
10321032
1A312A23

" => t.seq;
1.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
2 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STFILTERMOD fmod;
//fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 7 /* Q */, 400 /* f_base */ , 2400  /* f_var */, 1::second / (13 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STFILTERX stresx0; RES_XFACTORY stresx0_fact;
stresx0.connect(last $ ST ,  stresx0_fact, 10* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stresx0 $ ST @=>  last;  

//  STDELAY stdelay;
//  stdelay.connect(last $ ST , data.tick * 1. / 16. /* static delay */ );       stdelay $ ST @=>  last;  
//  
//  STAUTOPAN autopan;
//  autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 
//  
//  STAUTOPAN autopan2;
//  autopan2.connect(fmod $ ST, .5 /* span 0..1 */, data.tick * 2 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 
//  
//  STGAIN stgain;
//  stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
//  stgain.connect(autopan $ ST , 0.6 /* static gain */  );       stgain $ ST @=>  last; 
// 
// STGVERB stgverb;
// stgverb.connect(last $ ST, .3 /* mix */, 3 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.2 /* tail */ ); stgverb $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .5 /* mix */, 3 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.2 /* tail */ ); stgverb $ ST @=>  last; 


STLHPFC2 lhpfc2;
lhpfc2.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc2 $ ST @=>  last; 


<<<"*******************************">>>;
<<<"**        ARP LHPF FM        **">>>;
<<<"** lpd8 1.1 LHPF freq        **">>>;
<<<"** lpd8 1.2 LHPF Q           **">>>;
<<<"** lpd8 1.3 FM amp boost     **">>>;
<<<"*******************************">>>;


while(1) {
       100::ms => now;
}
 
