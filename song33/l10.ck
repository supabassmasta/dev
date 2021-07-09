TONE t;
t.reg(SERUM01 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.add(60 /* synt nb */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  1::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 1::ms /* release */ );
//s0.add(59 /* synt nb */ , 0.4 /* GAIN */, 1.001 /* in freq gain */,  1::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 1::ms /* release */ );
// s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
____ ___ *4 8531 :4
____ ___ *4 5831 :4
____ ___ *8 1_1_1_1_1_1_1_1_ 8_8_8_8_8_8_8_8_:8
____ ___ *8 8_1_8_1_8_1_8_1_9_2_9_2_a_3_b_c_ :8
" => t.seq;
.08 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

//ARP arp;
//arp.t.dor();
//0::ms => arp.t.glide;
//"*4 1111 8111 1111 1118/1 8181 1_1_1_1_ " => arp.t.seq;
//arp.t.go();   

// CONNECT SYNT HERE
//3 => s0.inlet.op;
//arp.t.raw() => s0.inlet; 

//STAUTOFILTERX stautohpfx0; HPF_XFACTORY stautohpfx0_fact;
//stautohpfx0.connect(last $ ST ,  stautohpfx0_fact, 2.0 /* Q */, 21 * 100 /* freq base */, 28 * 100 /* freq var */, data.tick * 17 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautohpfx0 $ ST @=>  last;  

STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 7 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
