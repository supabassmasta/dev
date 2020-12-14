13 => int mixer;


class synt0 extends SYNT{

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
  t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  .3 * data.master_gain => t.gain;
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

fun void slide (float start, float stop, dur d, ST @ st, float g, float w, dur ar){ 
      Step stp0 => Envelope e0 =>  TriOsc s => ADSR a => st.mono_in;
      start => e0.value;
      stop => e0.target;
      d => e0.duration ;// => now;
      
      1.0 => stp0.next;
      
      g => s.gain;
      w => s.width;

      a.set(ar, 0::ms, 1., ar);

      a.keyOn();

      d => now;

      a.keyOff();
      ar => now;
} 

fun void  SLIDES  (float a[], dur d[], float width, float g){ 
  3::ms => dur attackRelease;

   if (a.size() % 2 || d.size() != a.size() / 2) {
      <<<"SLIDES ERROR: input params must be [freq start, freq stop, .... ] [dur, ....]">>>;
   }
  else {
   
   ST st; st $ ST @=> ST @ last;


    

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
    0::ms => dur dmax;


    for (0 => int i; i < d.size()      ; i++) {
      spork ~ slide (a[i*2], a[i*2 + 1], d[i], st, g, width, attackRelease); 
      if ( d[i]> dmax  ){
         d[i] => dmax;   
      }
    }
     
   dmax + attackRelease => now;

  }

   
} 

//SLIDES([1.1, 2., 3.] @=> float b[]);

STMIX stmix;
//stmix.send(last, 11);
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 


WAIT w;
8 *data.tick => w.fixed_end_dur;
//2 * data.tick =>  w.wait; 

while(1) {
  [100., 500., 800., 300.] @=> float b[]; [1 * data.tick, 2* data.tick] @=> dur d[];
  spork ~  SLIDES(b, d, .5, .05); 

4 * data.tick =>  w.wait;

   spork ~  RAND("*4 }c", 12); 
   4 * data.tick =>  w.wait;
 
   spork ~   FROG(4, 10, 23 * 100, 100, 2* data.tick, .3); 
   4 * data.tick =>  w.wait;
// 
//   spork ~  RAND("*4 }c", 12); 
//   4 * data.tick =>  w.wait;
// 
//   spork ~   FROG(19, 4, 23 * 100, 12 * 100, 1* data.tick, .3); 
//   4 * data.tick =>  w.wait;
// 
//   spork ~  RAND("*4 }c", 12); 
//   4 * data.tick =>  w.wait;
// 
   spork ~   FROG(19, 4, 9 * 100, 24 * 100, 1* data.tick, .3); 
  [700., 100., 80., 300.] @=>  b; [1 * data.tick, 2* data.tick] @=>  d;
  spork ~  SLIDES(b, d, .9, .05); 

  4 * data.tick =>  w.wait;
// 
//   spork ~  RAND("*4 }c", 12); 
//   4 * data.tick =>  w.wait;
// 
//   spork ~  RAND("*4 }c", 12); 
//   4 * data.tick =>  w.wait;
// 
//   spork ~   FROG(10, 2, 3 * 100, 24 * 100, 1* data.tick, .3); 
//   1 * data.tick =>  w.wait;
//   spork ~   FROG(2, 20, 24 * 100, 4 * 100, 1* data.tick, .3); 
//   3 * data.tick =>  w.wait;

}
 

