class synt0 extends SYNT{

     16 => int synt_nb; 0 => int i;
     Gain detune[synt_nb];
     SERUM0 s[synt_nb];
     Gain final => outlet; .3 => final.gain;

      42 => int nb;
      0 => int rk;

     inlet => detune[i] => s[i] => final;    1. => detune[i].gain;       .6 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    1.0001 => detune[i].gain;    .2 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    1.0002 => detune[i].gain;    .2 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    1.0003 => detune[i].gain;    .2 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    1.0004 => detune[i].gain;    .2 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    0.99991 => detune[i].gain;   .2 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    0.99981 => detune[i].gain;   .2 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    0.99971 => detune[i].gain;   .2 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    0.99961 => detune[i].gain;   .2 => s[i].outlet.gain; s[i].config(nb, rk); i++; 

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);
//data.tick * 8 => t.max; //
600::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 {c 1111 1111 1111 111_ " => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 500 /* f_base */ , 300  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 14 * 10. /* room size */, 4::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

STREC strec;
strec.connect(last $ ST, 64*data.tick, "../../_SAMPLES/ambient_universe/bass1.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); strec $ ST @=>  last;  


while(1) {
       100::ms => now;
}
 


