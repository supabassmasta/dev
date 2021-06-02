class SYNTADD extends SYNT{
  SYNT @ syntl[0];
  1 => stereo;

  fun void  add(SYNT @ in, float g, float ifg) {
    if ( in.stereo  ){
      inlet => Gain i => in; 
      in.stout.left() => stout.outl;  in.stout.right() => stout.outr;
      g => in.stout.gain;
      ifg => i.gain;
      syntl << in;
    }
    else {
      inlet => Gain i => in => stout.outl;  in => stout.outr;
      g => in.outlet.gain;
      ifg => i.gain;
      syntl << in;
    }

  }

  fun void on()  { 
   for (0 => int i; i < syntl.size() ; i++) {
      syntl[i].on();
    }

  }

  fun void off() { 
    for (0 => int i; i < syntl.size() ; i++) {
      syntl[i].off();
    }
  } 

  fun void new_note(int idx)  {
    on();  
    for (0 => int i; i < syntl.size() ; i++) {
      syntl[i].new_note(idx);
    }
  }

0 => own_adsr;
} 


TONE t;
t.reg(SYNTADD syntadd); 

SYNTWAV synt0;
synt0.config(.5 /* G */, 500::ms /* ATTACK */, 1500::ms /* RELEASE */, 32 /* FILE */, 100::ms /* UPDATE */); 
syntadd.add(synt0 $ SYNT, .5 /* Gain */, 1. /* freq gain */); 

SYNTWAV synt1;
synt1.config(.5 /* G */, 500::ms /* ATTACK */, 1500::ms /* RELEASE */, 37 /* FILE */, 100::ms /* UPDATE */); 
syntadd.add(synt1 $ SYNT, .5 /* Gain */, 0.5 /* freq gain */); 

SYNTWAV synt2;
synt2.config(.5 /* G */, 500::ms /* ATTACK */, 1500::ms /* RELEASE */, 5 /* FILE */, 100::ms /* UPDATE */); 
syntadd.add(synt2 $ SYNT, .2 /* Gain */, 2.0 /* freq gain */); 

SYNTWAV synt3;
synt3.config(.5 /* G */, 500::ms /* ATTACK */, 1500::ms /* RELEASE */, 5 /* FILE */, 100::ms /* UPDATE */); 
syntadd.add(synt3 $ SYNT, .2 /* Gain */, 2.0 /* freq gain */); 
.9999 => synt3.rate;

NOISE0 s4;
syntadd.add(s4 $ SYNT, .3 /* Gain */, 4.0 /* freq gain */); 


t.ion();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":8 {c
11
" => t.seq;
.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 5* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STROTATE strot;
strot.connect(last $ ST , 0.2 /* freq */  , 0.5 /* depth */, 0.6 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
// => strot.sin0;  => strot.sin1; // connect to make freq change 

STGVERB stgverb;
stgverb.connect(last $ ST, .07 /* mix */, 4 * 10. /* room size */, 4::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 



while(1) {
       100::ms => now;
}
 
