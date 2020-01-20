11 => int n;
0 => int m;

TONE t;
t.reg(SERUM0 s0); s0.config(n,m);

//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 *2 }c}c
8_1_ 8_1_ 0_1_ 3_5_
1_3_ 8___ 5___ 1___
8_1_ 8_1_ 0_1_ 3_5_
1_3_ 8___ 5_1_ 1_8_

" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 1538158  " => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

STSYNCLPF stsynclpf;
stsynclpf.freq(3 * 100 /* Base */, 13 * 100 /* Variable */, 2. /* Q */);
stsynclpf.adsr_set(.1 /* Relative Attack */, .3/* Relative Decay */, .000001 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 


STHPF hpf;
hpf.connect(last $ ST , 200 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .2);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
