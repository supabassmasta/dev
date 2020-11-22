TONE t;
t.reg(SERUM0 s0);s0.config(26, 1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4*2 }c 
7__3 __B_ 5!3!0!1 __8_
7__3 __B_ 5!3!0!1 __8_

5!3!0!1__B_ 5!3!0!1 __8_
7__3 __f_ ____ ____

7__3 __g_ 5!3!0!1 __8_
7__3 __B_ ____ ____
:4:2
____
" => t.seq;
.1 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //
t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
0::ms => arp.t.glide;
"*4 1_38 5_8 538 _ 153 1_3" => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

SinOsc sin0 =>  OFFSET ofs0 => s0.inlet;
1. => ofs0.offset;
2.1 => ofs0.gain;

0.4 => sin0.freq;
1.0 => sin0.gain;


STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
