SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

TONE t;
t.reg(SERUM0 s0); s0.config(11, 2); //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8}c}c  1_3_ _2__ 1_1_ __0_:8__ ____ ____" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


SinOsc sin0 =>  OFFSET ofs0 => s0.inlet;
9. => ofs0.offset;
69. => ofs0.gain;

21.0 => sin0.freq;
2.0 => sin0.gain;


STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 


//while(1) {  100::ms => now;}
 

8 * data.tick => now;

1=>t.s.exit;
LAUNCHPAD_VIRTUAL.on.set(1335);


4 * data.tick => now;
LAUNCHPAD_VIRTUAL.off.set(1328);
1 * data.tick => now;




 
