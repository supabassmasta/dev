class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


TONE t;
//t.reg(SERUM0 s0);  s0.config(43, 0);//data.tick * 8 => t.max; //
t.reg(SERUM0 s0);  s0.config(42, 0);//data.tick * 8 => t.max; //
30::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  

0 => t.scale.size;
t.scale << 1 << 3 << 1 << 2 << 1 << 3 << 1;

"*4 }c

1012 1210 1___ ____
1231 2310 1___ ____
5656 5634 3434 2121
2101 2131 1___ ____
" => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(7::ms, 15::ms, .7, 40::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

DETUNE detune;
detune.base_synt(s0 /* base synt, controlling others */);
detune.reg_aux(SERUM0 aux1); aux1.config(43, 0); /* declare and register aux here */
detune.config_aux(1.0002 /* detune percentage */, .3 /* aux gain output */ );  

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 3 /* Q */, 2600 /* f_base */ , 6400  /* f_var */, 1::second / (13 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
