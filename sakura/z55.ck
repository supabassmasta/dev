NOREPLACE no;


fun void BRK () {
  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  "
    *4
    k__k __kt  u_t_ t_st
    ks_k kt_s ____ ____

    " => s.seq;
  .5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  //s.sync(4*data.tick);// s.element_sync(); 
  s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 


  STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
  stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 2 /* Q */, 2 /* order */, 2 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 
  // CONNECT THIS 

  STGAIN stgain;
  stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

  STADSR stadsr;
  stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 100::ms /* Sustain dur */,  10::ms /* release */);
  //stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
  stadsr.connect(stfreelpfx0 $ ST);  stadsr  $ ST @=>  last; 
  // stadsr.keyOn(); stadsr.keyOff(); 

  STMIX stmix;
  stmix.send(last, 11);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  ///////////////// AUTOMATION ///////////////////////

  Step stpauto =>  Envelope eauto =>  blackhole;
  1.0 => stpauto.next;
  100 => eauto.value; // INITIAL VALUE

  eauto => stfreelpfx0.freq; 


  //fun void f1 (){ 
  //  while(1) {
  //    eauto.last() => stfreelpfx0.freq; 
  //    10::ms => now; // REFRESH RATE
  //  }
  //}
  //spork ~ f1 ();


  9 * 1000.0 => eauto.target;
  8.0 * data.tick => eauto.duration;
  4 * data.tick => now;

  stadsr.keyOn();
  4 * data.tick => now;
  stadsr.keyOff();


  1 * 100.0 => eauto.target;
  1.0 * data.tick => eauto.duration  => now;

  //  24 * data.tick => now;
  ///////////////// AUTOMATION /////////////////////// 




}



fun void SLIDE () {


  TONE t;
  t.reg(SERUM0 s0); s0.config(39, 1); //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  ":4 G////f" => t.seq;
  .4 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 1 / 3 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 


  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 44* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 2 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STMIX stmix;
  stmix.send(last, 11);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

//  t.s.duration => now;
  16* data.tick => now;

}

STMIX stmix;
//stmix.send(last, 11);
stmix.receive(11); stmix $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .9);  ech $ ST @=>  last; 
.6 => ech.gain;


SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(16 * data.tick , 0::ms /* offset */); 

WAIT w;
8 *data.tick => w.fixed_end_dur;
//2 * data.tick =>  w.wait; 

spork ~ SLIDE();
8 * data.tick =>  w.wait;

LAUNCHPAD_VIRTUAL.off.set(11);
LAUNCHPAD_VIRTUAL.off.set(12);
LAUNCHPAD_VIRTUAL.off.set(21);

spork ~ BRK();

7.5 * data.tick =>  w.wait;
LAUNCHPAD_VIRTUAL.on.set(11);
.5 * data.tick =>  w.wait;
LAUNCHPAD_VIRTUAL.on.set(12);
LAUNCHPAD_VIRTUAL.on.set(21);

12 * data.tick =>  w.wait;
LAUNCHPAD_VIRTUAL.off.set(55);
1::ms => now;
