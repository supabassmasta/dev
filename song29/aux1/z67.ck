class synt0 extends SYNT{
8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SinOsc s[synt_nb];
Gain final => outlet; .6 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.002 => detune[i].gain;    .1 => s[i].gain; i++;  


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);
t.reg(synt0 s1); .8 => s1.outlet.gain;
t.reg(synt0 s2); .6 => s1.outlet.gain;
t.reg(synt0 s3); .4 => s1.outlet.gain;

//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":8 }c
 1|3|5_ 1|3|7|8_ 
 1|5|7_ 1|8|5|7_ 
" => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 8 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(700::ms, 500::ms, .8, 3000::ms);
t.adsr[1].set(700::ms, 500::ms, .8, 3000::ms);
t.adsr[2].set(700::ms, 500::ms, .8, 3000::ms);
t.adsr[3].set(700::ms, 500::ms, .8, 3000::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 6 * 10. /* room size */, 3::second /* rev time */, 0.3 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
