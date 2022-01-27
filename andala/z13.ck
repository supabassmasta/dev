TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //
8::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(25 /* synt nb */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc();
t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//"*4{c 12121212 5435 2345" => t.seq;
"*4 " + RAND.seq("121,2121,543,345,81,18,1818,8,_,1,5", 32) => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
":4 1Ff8  " => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

//STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
//stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 1.0 /* Q */, 1 * 100 /* freq base */, 103 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 2 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  


STLHPFC lhpfc;
lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][5] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 2 / 3 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}


