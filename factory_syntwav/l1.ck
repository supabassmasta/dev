TONE t;
t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //
s0.add(0 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, .5* data.tick /* release */ );
// s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
22::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c
8342 1421 ____ ____ 
8348 3421 ____ ____
3483 1421 ____ ____

" => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 

111111111111111111811111111111111F11111111

" => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 5 * 100 /* freq base */, 10 * 100 /* freq var */, data.tick * 13 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  



STROTATE strot;
strot.connect(last $ ST , 0.6 /* freq */  , 0.8 /* depth */, 1.0 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
// => strot.sin0;  => strot.sin1; // connect to make freq change 
4.8 => strot.gain;

STGAIN stgain;
stgain.connect(last $ ST , 0.5 /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(stautoresx0 $ ST , 0.2 /* static gain */  );       stgain $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
