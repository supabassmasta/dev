TONE t;
t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.add(0 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 10::ms /* release */ );
s0.add(0 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1.001 /* sustain */, 10::ms /* release */ );
s0.add(41 /* synt nb */ , 2 /* rank */ , 0.3 /* GAIN */, 1.0 /* in freq gain */,  3*data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 2*data.tick /* release */ );
// s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":2 
111_
AAA_
#0#0#0_
#0#0#0_
" => t.seq;
1.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERX stresx0; RES_XFACTORY stresx0_fact;
stresx0.connect(last $ ST ,  stresx0_fact, 1* 100.0 /* freq */ , 0.6 /* Q */ , 1 /* order */, 1 /* channels */ );       stresx0 $ ST @=>  last;  

STROTATE strot;
strot.connect(last $ ST , 3.6 /* freq */  , 0.5 /* depth */, 0.6 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
// => strot.sin0;  => strot.sin1; // connect to make freq change 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 


STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .7);  ech $ ST @=>  last; 

STEPC stepc; stepc.init(HW.lpd8.potar[1][2], 10 /* min */, 90 * 10 /* max */, 50::ms /* transition_dur */);
stepc.out =>  s0.inlet;

while(1) {
       100::ms => now;
}
 
