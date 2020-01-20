10 => int n;
0 => int m;

TONE t;
t.reg(SERUM0 s0); s0.config(n,m);

//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 *2 }c
8_1_ 8_1_ 0_1_ 3_5_
1_3_ 8___ 5___ 1___
8_1_ 8_1_ 0_1_ 3_5_
1_3_ 8___ 5___ 1___
8_1_ 8_1_ 0_1_ 3_5_
1_3_ __8_ 5_5_ 1_1_
8_1_ 8_1_ 0_1_ 3_5_
1_3_ __8_ 8_3_ 1_1_

" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 13 * 100 /* Variable */, 2. /* Q */);
stsynclpf.adsr_set(.1 /* Relative Attack */, .3/* Relative Decay */, .000001 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .2);  ech $ ST @=>  last; 

STFADEIN fadein;
fadein.connect(last, 32*data.tick);     fadein  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
