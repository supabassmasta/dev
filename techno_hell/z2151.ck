14 => int mixer;
fun void GLITCH (string seq, string seq_cutter, string seq_arp,  int instru ) {
  
  TONE t;
  t.reg(SERUM0 s0); s0.config(instru, 0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  seq => t.seq;
  .4 * data.master_gain => t.gain;
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
   
   .3 => mod.freq;
   
   1.3 => o.offset;
   .8 => o.gain;
   
  // MOD ////////////////////////////////
  
  STMIX stmix;
  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;
}

//spork ~ GLITCH("*8  8_3_5_1_______" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 {c 1538 3851 0083 B " /* seq_arp */, 23 /* instru */);


// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

WAIT w;
8 *data.tick => w.fixed_end_dur;
//4 * data.tick =>  w.wait; 

while(1) {
  spork ~ GLITCH("*8 }c }c  B_18__8__1_" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 3/1B1/55811 " /* seq_arp */, 20 /* instru */);


  8 * data.tick =>  w.wait; 
spork ~ GLITCH("*4  35_18_3_______" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 3/11/5581B1 " /* seq_arp */, 23 /* instru */);


  8 * data.tick =>  w.wait;
  
  spork ~ GLITCH("*8 }c  8__8__1_B_1" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 3/11/5581B1 " /* seq_arp */, 20 /* instru */);


  8 * data.tick =>  w.wait; 

spork ~ GLITCH("*8  8_3_5_1_______" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 3/11/5581B1 " /* seq_arp */, 23 /* instru */);


  8 * data.tick =>  w.wait; 
}

