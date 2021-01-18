TONE t;
t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.add(8 /* synt nb */ , 0 /* rank */ , 0.2 /* GAIN */, 1.0 /* in freq gain */,  10::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 2* data.tick /* release */ );
s0.add(8 /* synt nb */ , 0 /* rank */ , 0.2 /* GAIN */, 1.01 /* in freq gain */,  10::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 2* data.tick /* release */ );
s0.add(8 /* synt nb */ , 0 /* rank */ , 0.2 /* GAIN */, 0.991 /* in freq gain */,  10::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 2* data.tick /* release */ );
// s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c 
1111 1111 3333 1111
1111 1111 AAAA 0000



" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
sthpfx0.connect(last $ ST ,  sthpfx0_fact, 6* 10.0 /* freq */ , 4. /* Q */ , 1 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  


STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 20* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
