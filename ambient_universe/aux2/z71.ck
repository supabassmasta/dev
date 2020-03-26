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


STREC strec;
strec.connect(last $ ST, 32*data.tick, "../../_SAMPLES/ambient_universe/ambraw1.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); strec $ ST @=>  last;  


while(1) {
       100::ms => now;
}
 


