
TONE t;
t.reg(PSYBASS0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*3  !1!1!1" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 6* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 2 /* order */, 1 /* channels */ , 1::samp /* period */ ); stfreehpfx0 $ ST @=>  last; 

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 


 ///////////////// AUTOMATION ///////////////////////

  


 Step stpauto =>  Envelope eauto => stfreehpfx0.freq; // CONNECT THIS 
 4 => eauto.value; // INITIAL VALUE

// 1.0 => stpauto.next;

SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(32 * data.tick , - 8 * data.tick /* offset */); 


 while(1) {
   9 * 100.0 => eauto.target;
   7.8 * data.tick => eauto.duration  => now;

   4.0 => eauto.target;
//   4.0 => eauto.value;
   0.2 * data.tick => eauto.duration  => now;

   24 * data.tick => now; 

 }
 ///////////////// AUTOMATION /////////////////////// 
 
