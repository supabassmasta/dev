TONE t;
t.reg(SYNTADD syntadd);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
SYNTWAV s0;
s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 36 /* FILE */, 100::ms /* UPDATE */); 
syntadd.add(s0 $ SYNT, .5 /* Gain */, 1. /* freq gain */); 

SinOsc sin0 =>  blackhole;
7.1 => sin0.freq;
0.00 => sin0.gain;


fun void f1 (){ 
  while(1) {
    if ( s0.lastbuf != NULL ){
       sin0.last() + 1. => s0.lastbuf.rate;  
    }
  1::samp => now;
  }
} 
//spork ~ f1 ();


//SYNTWAV s1;
//s1.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 14 /* FILE */, 100::ms /* UPDATE */); 
//syntadd.add(s1 $ SYNT, .3 /* Gain */, 1/* freq gain */); 
//.5 => s1.rate;

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 1" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STROTATE strot;
strot.connect(last $ ST , 0.12 /* freq */  , 0.6 /* depth */, -0.6 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
// => strot.sin0;  => strot.sin1; // connect to make freq change 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .07 /* mix */, 4 * 10. /* room size */, 4::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 



while(1) {
if ( s0.lastbuf != NULL ){
    
//.5 => s0.lastbuf.rate;
}
       100::ms => now;
}
 
