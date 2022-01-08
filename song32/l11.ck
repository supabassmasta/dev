TONE t;
t.reg(SYNTADD syntadd);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
SYNTWAV s0;
s0.config(.3 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 13 /* FILE */, 100::ms /* UPDATE */); 
syntadd.add(s0 $ SYNT, .5 /* Gain */, 1. /* freq gain */); 

SYNTWAV s1;
s1.config(.6 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 42 /* FILE */, 100::ms /* UPDATE */); 
syntadd.add(s1 $ SYNT, .3 /* Gain */, 1/* freq gain */); 
.5 => s1.rate;

t.reg(SYNTWAV s2);
s2.config(1.3 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, 39 /* FILE */, 100::ms /* UPDATE */);
// s0.pos s0.rate s0.lastbuf 

//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 1|M" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STROTATE strot;
strot.connect(last $ ST , 0.15 /* freq */  , 0.5 /* depth */, -0.6 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
// => strot.sin0;  => strot.sin1; // connect to make freq change 

//STGVERB stgverb;
//stgverb.connect(last $ ST, .07 /* mix */, 4 * 10. /* room size */, 4::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

class STTOAUX extends ST{
  Gain gainl => outl;
  Gain gainr => outr;

  1. => gainl.gain => gainr.gain;

  fun void connect(ST @ tone, float g2main, float g2aux, int stnb) {
    // TO main
    tone.left() => gainl;
    tone.right() => gainr;
    g2main => gainl.gain => gainr.gain;

    // To AUX
    if (stnb != 0) {
    tone.left() => Gain auxl=> dac.chan(2*stnb);
    tone.right() => Gain auxr =>dac.chan(2*stnb + 1);
    g2aux => auxl.gain => auxr.gain;
    }
    else {
      <<<"ERROR: STTOAUX, Stereo pair index 0 means main">>>;

    }
  }


}

STTOAUX sttoaux0; 
sttoaux0.connect(last $ ST ,  1.0 /* gain to main */, 0.1  /* gain  to aux */, 1 /* st pair number */ ); sttoaux0 $ ST @=>  last;

while(1) {
       100::ms => now;
}
 
