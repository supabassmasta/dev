TONE t;
t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.add(7 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
// s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//1131 11A0
//1131 11A0
//1131 11A0
//*4 1111 1111 3131 1313 1111 1111 A0A0 00AA :4
"}c 
:4
1131 11A0
11 *8*2 3131 3131  3331 3111 :8:2  1
11 *8*2 A0A0 A0A0  AAA0 A000 A0A0 A0A0  AAA0 A000 :8:2  

" => t.seq;
.35 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STCUTTER stcutter;
"*8 1_" => stcutter.t.seq;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STAUTOFILTERX stautohpfx0; HPF_XFACTORY stautohpfx0_fact;
stautohpfx0.connect(last $ ST ,  stautohpfx0_fact, 3.0 /* Q */, 12 * 10 /* freq base */, 20 * 100 /* freq var */, data.tick * 23 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautohpfx0 $ ST @=>  last;  

while(1) {
       100::ms => now;
}


