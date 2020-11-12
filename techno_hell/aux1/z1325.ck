SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

TONE t;
t.reg(FROG3 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" {c  _G/h_ __h//G_" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

//STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
//stautoresx0.connect(last $ ST ,  stautoresx0_fact, 0.5 /* Q */, 13 * 100 /* freq base */, 17 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 10* 100.0 /* freq */ , 3.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//while(1) {  100::ms => now;}

8 * data.tick => now;

// Stop seq
1=>t.s.exit;

// NEXT 
LAUNCHPAD_VIRTUAL.on.set(1326);

8 * data.tick => now;

// AUTOKILL
LAUNCHPAD_VIRTUAL.off.set(1325);
1 * data.tick => now;




 
