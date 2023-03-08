12 => int mixer;


fun void MOD1 () {
  ST st;

  SinOsc tri0 =>  SinOsc sin0 =>  st.mono_in; st $ ST @=> ST last;
  10.0 => sin0.freq;
  0.01 => sin0.gain;

  6.0 => tri0.freq;
  34.0 *100=> tri0.gain;
//  0.5 => tri0.width;

  STMIX stmix;
  stmix.send(last, 12);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1 * data.tick => now;

}


fun void MOD2 () {
  ST st;

  TriOsc tri0 =>  SinOsc sin0 =>  st.mono_in; st $ ST @=> ST last;
  10.0 => sin0.freq;
  0.01 => sin0.gain;

  1.0 => tri0.freq;
  34.0 *100=> tri0.gain;
  0.5 => tri0.width;

  STMIX stmix;
  stmix.send(last, 12);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1 * data.tick => now;

}


fun void MOD3 () {
  ST st;

  TriOsc tri0 =>  SinOsc sin0 =>  st.mono_in; st $ ST @=> ST last;
  10.0 => sin0.freq;
  0.02 => sin0.gain;

  1.0 => tri0.freq;
  34.0 *100=> tri0.gain;
  0.0 => tri0.width;

  STMIX stmix;
  stmix.send(last, 12);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1 * data.tick => now;

}

fun void GLITCH (string seq, int instru, dur dura , float g ) {

  TONE t;
  t.reg(SERUM0 s0); s0.config(instru, 0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  "*8 "  + seq => t.seq;
  g * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 


  STCUTTER stcutter;
  stcutter.t.no_sync();
  " *2 11__ 1_1_ 111_ 1__1 1111 1_1_" => stcutter.t.seq;
  stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

  STGVERB stgverb;
  stgverb.connect(last $ ST, .1 /* mix */, 7 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.5 /* tail */ ); stgverb $ ST @=>  last; 

  ARP arp;
  arp.t.dor();
  50::ms => arp.t.glide; 
  arp.t.no_sync();
  "*4 {c 1538 3851 0083 B " => arp.t.seq;
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

  1.2 => o.offset;
  .7 => o.gain;

  // MOD ////////////////////////////////

  STMIX stmix;
  stmix.send(last, 12);

  dura  => now;

}



fun void PAD ( string seq, int n, int k, float v) {


TONE t;
t.reg(SERUM0 s0); s0.config(n, k); //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM0 s1); s1.config(n, k); //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
v * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2 * data.tick, 10::ms, .2, 400::ms);
t.adsr[1].set(2 * data.tick, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 10* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STMIX stmix;
stmix.send(last, mixer);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}


STMIX stmix;
//stmix.send(last, 11);
stmix.receive(12); stmix $ ST @=> ST last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

WAIT w;
8 *data.tick => w.fixed_end_dur;

while(1) {

   spork ~ PAD("}c  :4 5|7_", 1, 0, .4);
   4 * data.tick =>  w.wait; 


    spork ~ GLITCH("}c}c G///f", 16, 1 * data.tick , 0.15);
    4 * data.tick =>  w.wait; 
 
    spork ~ MOD3();
    4 * data.tick =>  w.wait; 
 
   spork ~ PAD("}c 5|9", 1, 0, .5);
   4 * data.tick =>  w.wait; 


 
    spork ~ GLITCH("}c}c *4 312390480", 8, 1 * data.tick , 0.2);
    4 * data.tick =>  w.wait; 
 
    spork ~ MOD1();
    4 * data.tick =>  w.wait; 
  
   spork ~ PAD("}c 3|5", 1, 1, .5);
   4 * data.tick =>  w.wait; 

    spork ~ GLITCH("}c*2 f/G_", 34, 1 * data.tick, 0.4);
    4 * data.tick =>  w.wait; 
  
   spork ~ PAD("}c 2|7", 1, 1, .5);
   4 * data.tick =>  w.wait; 
  
    spork ~ MOD2();
    4 * data.tick =>  w.wait; 
  
    2 * data.tick => now;

 
 
}

