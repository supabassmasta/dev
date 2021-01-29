TONE t;
t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(11 /* synt nb */ );
// s0.set_chunk(0); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
}c
*8 111_1_1_1_1_1___ :8
*8 111_1_1_1_1_1___ :8
*8 111_1_1_1_1_1___ :8
*8 111_1_1_1_1_1___ :8
{c +4
*8 111_1_1_1_1_1___ :8
*8 111_1_1_1_1_1___ :8
*8 111_1_1_1_1_1___ :8
*8 111_1_1_1_1_1___ :8
" => t.seq;

.5 * data.master_gain => t.gain;
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last;

STAUTOPAN autopan;
autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

//ARP arp;
//arp.t.dor();
//0::ms => arp.t.glide;
//"*8 111_1_1_153/21_ 15/38  " => arp.t.seq;
//arp.t.go();   
//
// CONNECT SYNT HERE
//3 => s0.inlet.op;
//arp.t.raw() => s0.inlet; 




//SinOsc sin0 =>  s0.inlet;
//2.0 => sin0.freq;
//5.0 => sin0.gain;


SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 
while(1) {
s0.set_chunk( Std.rand2(0, 63) ); 
.25 * data.tick => now;       
}
 
