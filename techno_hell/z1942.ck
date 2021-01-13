18 => int mixer;

fun void  SLIDESERUM1  (float fstart, float fstop, dur d, float g){ 
  1 * data.tick => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  SERUM1 s0 => st.mono_in;
   s0.add(23 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  8 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, attackRelease /* release */ ); 
   s0.add(14 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */,3* data.tick /* release */ ); 
   s0.add(14 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 1.001 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */,3* data.tick /* release */ ); 

SinOsc sin0 =>  s0.sl[0].inlet;
10.0 => sin0.freq;
60.0 => sin0.gain;



   fstart => e0.value;
   fstop => e0.target;
   d => e0.duration ;// => now;
   
   1.0 => stp0.next;
   
   g => st.gain;

   s0.on();

   d => now;

   s0.off();
   attackRelease => now;
    
} 


fun void ACOUSTICTOM(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTICTOM(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .7 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

fun void ACOUSTICTOM_EFFECT(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTICTOM(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .7 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

fun void TRANCEBREAK(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .8 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
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



// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .2 /* span 0..1 */, data.tick * 3 / 4 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 



SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
8 *data.tick => w.fixed_end_dur;

    spork ~  SLIDESERUM1(2000 /* fstart */, 37 /* fstop */, 8* data.tick /* dur */,  .10 /* gain */); 
    
    8 * data.tick =>  w.wait; 
LAUNCHPAD_VIRTUAL.off.set(1911);
LAUNCHPAD_VIRTUAL.off.set(1912);
LAUNCHPAD_VIRTUAL.off.set(1913);
LAUNCHPAD_VIRTUAL.off.set(1914);
LAUNCHPAD_VIRTUAL.off.set(1921);


   spork ~ ACOUSTICTOM("*6 AAABBB CCCDDD UKKUUK SABCDU ");
   spork ~  TRANCEBREAK ("____ *8 L___ L_L_ LLLL LLLL*2 LLLL LLLL LLLL LLLLLLLL LLLL LLLL LLLL"); 
   8 * data.tick =>  w.wait; 
   spork ~   SINGLEWAV("../_SAMPLES/Kecak/kecak.wav", .5); 

    4 * data.tick - 1::samp =>  w.wait; 
    spork ~  SLIDESERUM1(20/* fstart */, 3000 /* fstop */, 4* data.tick /* dur */,  .12 /* gain */); 
    
   spork ~ ACOUSTICTOM("__ *4 ABCD :4 *6 +2U+2A+2B+2C+2D+2U ");
//   spork ~ ACOUSTICTOM_EFFECT("___ *6 ___ __U ");
//   spork ~ ACOUSTICTOM_EFFECT(" ____ *2 _U ");
    4 * data.tick - 1::samp =>  w.wait; 
LAUNCHPAD_VIRTUAL.on.set(1911);
.25 * data.tick =>  w.wait;
LAUNCHPAD_VIRTUAL.on.set(1912);
LAUNCHPAD_VIRTUAL.on.set(1921);
   8 * data.tick =>  w.wait; 
LAUNCHPAD_VIRTUAL.off.set(1942); // AUTOOFF
   8 * data.tick =>  w.wait; 
  
