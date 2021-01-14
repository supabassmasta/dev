16 => int mixer;
 
fun void  SUPLEADHPF  (string seq, float v){ 
  TONE t;
  t.reg(SUPERSAW0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 
  t.no_sync();//1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  //STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
  //stbpfx0.connect(last $ ST ,  stbpfx0_fact, 91* 100.0 /* freq */ , 2.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  
  //9. => stbpfx0.gain;

  STFILTERX stresx0; RES_XFACTORY stresx0_fact;
  stresx0.connect(last $ ST ,  stresx0_fact, 91* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stresx0 $ ST @=>  last;  

  STAUTOFILTERX stautohpfx0; HPF_XFACTORY stautohpfx0_fact;
  stautohpfx0.connect(last $ ST ,  stautohpfx0_fact, 2.3 /* Q */, 4 * 100 /* freq base */, 55 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautohpfx0 $ ST @=>  last;  

  STCOMPRESSOR stcomp;
  25. => float in_gain;
  stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   

  3.2 => stcomp.gain;

  STMIX stmix;
  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

} 


fun void GLITCH (string seq, string seq_cutter, string seq_arp,  int instru , float g) {
  
  TONE t;
  t.reg(SERUM0 s0); s0.config(instru, 4);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  seq => t.seq;
  g * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 
  
  
  STCUTTER stcutter;
  stcutter.t.no_sync();
  seq_cutter => stcutter.t.seq;
  stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 
  
  STGVERB stgverb;
  stgverb.connect(last $ ST, .1 /* mix */, 7 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.5 /* tail */ ); stgverb $ ST @=>  last; 
  
  ARP arp;
  arp.t.dor();
  50::ms => arp.t.glide; 
  arp.t.no_sync();
  seq_arp => arp.t.seq;
  arp.t.go();   
  
  // CONNECT SYNT HERE
  3 => s0.inlet.op;
  arp.t.raw() => s0.inlet; 
  
  
  // MOD ////////////////////////////////
  
   SinOsc mod => SinOsc s => OFFSET o => s0.inlet;
   1::second / (13 * data.tick) => s.freq;
 
//   SYNC sy;
//   sy.sync(1 * data.tick);
   //sy.sync(4 * data.tick , 0::ms /* offset */); 
   0 => s.phase;
   
   .2 => mod.freq;
   
   1.9 => o.offset;
   .9 => o.gain;
   
  // MOD ////////////////////////////////
  
  STMIX stmix;
  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;
}



STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 2 / 3 , .7);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .05 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 



SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
0 *data.tick => w.fixed_end_dur;
//4 * data.tick =>  w.wait; 
while(1) {

  spork ~ SUPLEADHPF("*3 }c 8__ _5_ ___ 3__    1__ 1__ ___ ___ ", 0.5 /* gain */);
  4 * data.tick =>  w.wait; 

  spork ~ GLITCH("*6*2 }c 30_5_*31_1_1_1  " /* seq */,  " 1" /* seq_cutter */,  "*3 {c 1538 3851 0083 B " /* seq_arp */, 16 /* instru */, .7 /* gain */);

  4 * data.tick =>  w.wait; 
  spork ~ SUPLEADHPF("*3 }c G///f ", 0.3 /* gain */);
  4 * data.tick =>  w.wait; 
  spork ~ GLITCH("*6*2 }c}c 3_0__5__1  " /* seq */,  " 1" /* seq_cutter */,  "*3 {c 1538 3851 0083 B " /* seq_arp */, 18 /* instru */, .5 /* gain */);

  4 * data.tick =>  w.wait; 
  spork ~ SUPLEADHPF("*3 }c 8__ _5_ ___ 3__    1__ 1__ ___ ___ ", 0.5 /* gain */);
  4 * data.tick =>  w.wait; 
  spork ~ GLITCH("*6*2 }c}c 1_1_1___1  " /* seq */,  " 1" /* seq_cutter */,  "*3 {c 1538 3851 0083 B " /* seq_arp */, 19 /* instru */, .5 /* gain */);


  4 * data.tick =>  w.wait; 
  spork ~ SUPLEADHPF("*3 }c f////GG//1_ ", 0.3 /* gain */);
  4 * data.tick =>  w.wait; 
  spork ~ GLITCH("*6*2 }c}c 15818  " /* seq */,  " 1" /* seq_cutter */,  "*3 {c 1538 3851 0083 B " /* seq_arp */, 19 /* instru */, .5 /* gain */);
  4 * data.tick =>  w.wait; 

}
 
