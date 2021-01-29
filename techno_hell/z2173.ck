TONE t;
t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(11 /* synt nb */ );
// s0.set_chunk(0); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
}c 
*8 111_1_1_1_1_1___ :8 __ ____
" => t.seq;

.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
t.go();   t $ ST @=> ST @ last;

STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 100::ms /* Sustain dur */,  10::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff(); 

//STAUTOPAN autopan;
//autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(ech $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 



ARP arp;
arp.t.dor();
1 * data.tick =>arp.t.the_end.fixed_end_dur; 
0::ms => arp.t.glide;
"*8 11111181111181111111811111111  " => arp.t.seq;
arp.t.go();   
//
// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 




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
 
