class synt0 extends SYNT{

     16 => int synt_nb; 0 => int i;
     Gain detune[synt_nb];
     SERUM0 s[synt_nb];
     Gain final => outlet; .3 => final.gain;

      13 => int nb;
      0 => int rk;

     inlet => detune[i] => s[i] => final;    1. => detune[i].gain;       .6 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    1.001 => detune[i].gain;    .4 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    1.002 => detune[i].gain;    .4 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    1.003 => detune[i].gain;    .4 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    1.004 => detune[i].gain;    .4 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    0.9991 => detune[i].gain;   .4 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    0.9981 => detune[i].gain;   .4 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    0.9971 => detune[i].gain;   .4 => s[i].outlet.gain; s[i].config(nb, rk); i++; 
     inlet => detune[i] => s[i] => final;    0.9961 => detune[i].gain;   .4 => s[i].outlet.gain; s[i].config(nb, rk); i++; 

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //
600::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 15301___" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STDELAY stdelay;
stdelay.connect(last $ ST , data.tick * 2. / 4. /* static delay */ );       stdelay $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 2 / 4 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STAUTOPAN autopan2;
autopan2.connect(t $ ST, .6 /* span 0..1 */, data.tick * 3 / 4 /* period */, 0.95 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(autopan $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

STREC strec;
strec.connect(last $ ST, 32*data.tick, "../../_SAMPLES/ambient_universe/ambpan1.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); strec $ ST @=>  last;  


while(1) {
       100::ms => now;
}
 


