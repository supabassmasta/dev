class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
8 => int nb;
0 => int rank;
t.reg(SERUM0 s0); 
s0.config(nb, rank); //data.tick * 8 => t.max; 
20::ms => t.glide;  // t.lyd(); // 
t.ion(); // t.mix();//
//t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" 1^23^210" => t.seq;
.1 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

.8 => t.outr.gain;
.2 => t.outl.gain;

DETUNE detune;
detune.base_synt(s0 /* base synt, controlling others */);
detune.reg_aux(SERUM0 aux1); aux1.config(nb, rank);
detune.config_aux(1.021 /* detune percentage */, .6 /* aux gain output */ );  
detune.reg_aux(SERUM0 aux2); aux2.config(nb, rank);
detune.config_aux(0.984 /* detune percentage */, .6 /* aux gain output */ );  

STLHPFC2 lhpfc2;
lhpfc2.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc2 $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
