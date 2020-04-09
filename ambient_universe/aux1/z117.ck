
class synt0 extends SYNT{

  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  Step det_amount[synt_nb];
  SERUM0 s[synt_nb];
  Gain final => outlet; .8 => final.gain;
  
//  4 => int nb;
//  2 => int rk;

//  6 => int nb;
//  1 => int rk;
  7 => int nb;
  0 => int rk;

  inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  0 => det_amount[i].next;      .9 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  8 => det_amount[i].next;      .1 => s[i].gain; i++;  
//  inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
}


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":2 }c 
1///1_ {c 7///7_ 4///4_ 5///5_

" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
4 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(20::ms, 10::ms, 1., 600::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

//DETUNE detune;
//detune.base_synt(s0 /* base synt, controlling others */);
//detune.reg_aux(SERUM0 aux1); aux1.config(4, 0);/* declare and register aux here */
//detune.config_aux(0.5 /* detune percentage */, .4 /* aux gain output */ );  

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 6 * 100 /* f_base */ , 24 * 100  /* f_var */, 8::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 4 * 100 /* Variable */, 1. /* Q */);
stsynclpf.adsr_set(.6 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

//STLPFC2 lpfc2;
//lpfc2.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lpfc2 $ ST @=>  last; 



    while(1) {
           100::ms => now;
    }
     

