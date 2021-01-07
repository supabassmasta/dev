class SERUM1 extends SYNT{

  ADSR @ al[0];
  SERUM0 @ sl[0]; // to access synt after, to hack it

  fun void  add(int n, int k, float g, float ifg, dur  at, dur d, float su, dur r ){ 
    inlet => Gain i => SERUM0 s => ADSR a  => outlet; 
    g => s.outlet.gain;
    ifg => i.gain;
    s.config(n, k);
    a.set(at, d, su, r);
    al << a;
    sl << s;
  } 

  fun void on()  { 
    for (0 => int i; i < al.size() ; i++) {
      al[i].keyOn();
    }

  }

  fun void off() { 
    for (0 => int i; i < al.size() ; i++) {
      al[i].keyOff();
    }
  } 

  fun void new_note(int idx)  {
    on();  
  }

  1 => own_adsr;
} 



TONE t;
t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.add(36 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  4 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
s0.add(10 /* synt nb */ , 0 /* rank */ , 1.1 /* GAIN */, 1.0 /* in freq gain */,  3::ms /* attack */, 3 * data.tick /* decay */, .0001 /* sustain */, 1* data.tick /* release */ );
s0.add(13 /* synt nb */ , 0 /* rank */ , 0.7 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 1 * data.tick /* decay */, .4 /* sustain */, 3* data.tick /* release */ );
s0.add(13 /* synt nb */ , 0 /* rank */ , 0.7 /* GAIN */, 1.01 /* in freq gain */,  2 * data.tick /* attack */, 1 * data.tick /* decay */, .4 /* sustain */, 3* data.tick /* release */ );

t.reg(SERUM1 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s1.add(36 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  4 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
s1.add(10 /* synt nb */ , 0 /* rank */ , 1.1 /* GAIN */, 1.0 /* in freq gain */,  3::ms /* attack */, 3 * data.tick /* decay */, .0001 /* sustain */, 1* data.tick /* release */ );
s1.add(13 /* synt nb */ , 0 /* rank */ , 0.7 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 1 * data.tick /* decay */, .4 /* sustain */, 3* data.tick /* release */ );
s1.add(13 /* synt nb */ , 0 /* rank */ , 0.7 /* GAIN */, 1.01 /* in freq gain */,  2 * data.tick /* attack */, 1 * data.tick /* decay */, .4 /* sustain */, 3* data.tick /* release */ );

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":8 {c 1|3_5|0_ " => t.seq;
.32 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

// Mod
SinOsc sin0 =>  s0.sl[0].inlet;
4.0 => sin0.freq;
1.0 => sin0.gain;


STROTATE strot;
strot.connect(last $ ST , 1.6 /* freq */  , 0.01 /* depth */, 0.01 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
// => strot.sin0;  => strot.sin1; // connect to make freq change 

STGVERB stgverb;
stgverb.connect(last $ ST, .15 /* mix */, 6 * 10. /* room size */, 3::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
