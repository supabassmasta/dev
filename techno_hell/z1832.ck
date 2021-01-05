14 => int mixer;
class syntRand extends SYNT{
    inlet => SinOsc s =>  outlet; 
    .5 => s.gain;

     fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


fun void  RAND  (string begin, int nb){ 

  string s;

  begin => s;

  for (0 => int i; i <   nb    ; i++) {
    Std.randf()/2 + .5 => float p;
    if ( p > .4) {
      ["1", "1", "3", "5", "8", "_", "_", "_" ] @=> string a1[];
      a1[ Std.rand2(0, a1.size() - 1) ] +=> s;
    }
    else if (  p > .2  ){
      ["2", "4", "6", "7" ] @=> string a1[];
      a1[ Std.rand2(0, a1.size() - 1) ] +=> s;
    }
    else {
      ["{c 5 }c", "{c 7 }c" ] @=> string a1[];
      a1[ Std.rand2(0, a1.size() - 1) ] +=> s;
    }

  }
  <<<"STRING", s>>>;


  TONE t;
  t.reg(PLOC0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  .4 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 

  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();

  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 


 STMIX stmix;
 stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // Let duration computed by go() sub sporking
  t.s.duration => now;
  0 => t.on;
  1 * data.tick => now;
//  2 * data.tick => now;

} 

fun void  FROG  (float fstart, float fstop, float lpfstart, float lpfstop, dur d, float g){ 
    ST st; st $ ST @=> ST @ last;

    Step step => Envelope e0 => SqrOsc s => st.mono_in;
    1. => step.next;
    .2 => s.gain;

    fstart => e0.value;
    fstop => e0.target;
    d => e0.duration ;// => now;

    STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
    stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 3 /* Q */, 2 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 

    g => stfreelpfx0.gain;

    Step step2 => Envelope e1 =>  stfreelpfx0.freq; // CONNECT THIS 
    lpfstart => e1.value;
    lpfstop => e1.target;
    d => e1.duration ;// => now;

    1. => step2.next;

    
    STHPF hpf;
    hpf.connect(last $ ST , 5 * 10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

    STMIX stmix;
    stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    d => now;

} 


fun void  SINGLEWAV  (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer);
   
   g => s.gain;

   file => s.read;

   s.length() => now;
} 

fun void  SINGLEWAVRATE  (string file, float r, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer);
   r => s.rate;
   g => s.gain;

   file => s.read;

   s.length() * (1./r) => now;
} 


STMIX stmix;
//stmix.send(last, mixer);
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .07 /* mix */, 9 * 10. /* room size */, 2::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .5);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .8 /* span 0..1 */, data.tick * 2 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 


SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

WAIT w;
8 *data.tick => w.fixed_end_dur;

fun void  VOICES  (){ 
   WAIT w;
   8 *data.tick => w.fixed_end_dur;
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/AChaqueFois.wav", .6); 
   16 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/EnPrendreCombien.wav", .4); 
   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/CaJenSaisRien.wav", .6); 
   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .6); 
   4 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .8,  .6); 
   4 * data.tick =>  w.wait; 
   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .6, .6); 
   16 * data.tick =>  w.wait; 
//   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/.wav", .4); 
//   spork ~   SINGLEWAV("../_SAMPLES/HighMaintenance/.wav", .4); 
} 

spork ~  VOICES (); 


while(1) {

 
  spork ~   FROG(19 /* fstart */, 4 /* fstop */, 9 * 100 /* lpfstart */, 24 * 100 /* lpfstop */, 2* data.tick /* dur */, .1 /* gain */);
  spork ~   RAND ("}c *4 ", 6);   4 * data.tick =>  w.wait; 
  spork ~   RAND ("}c *4 ", 6);   4 * data.tick =>  w.wait; 
  spork ~   FROG(29 /* fstart */, 2 /* fstop */, 9 * 100 /* lpfstart */, 34 * 100 /* lpfstop */, 1* data.tick /* dur */, .1 /* gain */);
  spork ~   RAND ("}c *4 ", 6);   4 * data.tick =>  w.wait; 
  spork ~   RAND ("}c *4 ", 6);   4 * data.tick =>  w.wait; 


}

