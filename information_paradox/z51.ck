TONE t;
t.reg(SERUM01 s0);  //data.tick * 8 => t.max; //
20::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.add(64 /* synt nb */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  .5::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, .5 * data.tick /* release */ );
//s0.add(64 /* synt nb */ , 0.05 /* GAIN */, 1.0001 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
// s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4
8351835183518351 
8631863186318631
#724#0#724#0#724#0#724#0
#724#0#724#0#724#0#724#0

" => t.seq;
.18 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 1.3 /* Q */, 5 * 100 /* freq base */, 8 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
sthpfx0.connect(last $ ST ,  sthpfx0_fact, 3* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  
STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 6 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .1);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 

