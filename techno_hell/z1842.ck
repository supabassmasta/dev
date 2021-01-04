13 => int mixer;

fun void  SLIDENOISE  (float fstart, float fstop, dur d, float width, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  NOISE1 s => ADSR a => st.mono_in;
   fstart => e0.value;
   fstop => e0.target;
   d => e0.duration ;// => now;

   SinOsc sin0 =>  s;
   10.0 => sin0.freq;
   200.0 => sin0.gain;

   
   1.0 => stp0.next;
   
   g => s.gain;
//   width => s.width;

   a.set(attackRelease, 0::ms, 1., attackRelease);

   a.keyOn();

   d => now;

   a.keyOff();
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

fun void MOD1 () {
  ST st;

  SinOsc tri0 =>  SinOsc sin0 =>  st.mono_in; st $ ST @=> ST last;
  10.0 => sin0.freq;
  0.03 => sin0.gain;

  5.0 => tri0.freq;
  25.0 *100=> tri0.gain;
//  0.5 => tri0.width;

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  4 * data.tick => now;

}



STMIX stmix;
//stmix.send(last, 11);
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 




SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
8 *data.tick => w.fixed_end_dur;



spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 

4 * data.tick =>  w.wait; 

LAUNCHPAD_VIRTUAL.off.set(1811);
LAUNCHPAD_VIRTUAL.off.set(1812);
LAUNCHPAD_VIRTUAL.off.set(1821);

spork ~ ACOUSTICTOM("*4 A_AB B_CC D_DV UNNU ");


4 * data.tick =>  w.wait; 

LONG_WAV l;
"../_SAMPLES/HighMaintenance/DrgRecreative.wav" => l.read;
0.4 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(1::samp /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=>  last;  

//STECHO ech2;
//ech2.connect(last $ ST , data.tick * 1 / 2 , .4);  ech $ ST @=>  last; 

//STMIX stmix2;
//stmix2.send(last, mixer);
//stmix.receive(11); stmix $ ST @=> ST @ last; 


4 * data.tick =>  w.wait; 

spork ~   MOD1 (); 
spork ~  SLIDENOISE(4000 /* fstart */, 200 /* fstop */, 4* data.tick /* dur */, .5 /* width */, .17 /* gain */); 
3.5 * data.tick =>  w.wait; 
LAUNCHPAD_VIRTUAL.on.set(1811);
.5 * data.tick =>  w.wait; 
LAUNCHPAD_VIRTUAL.on.set(1812);
LAUNCHPAD_VIRTUAL.on.set(1821);
8 * data.tick =>  w.wait; 
LAUNCHPAD_VIRTUAL.off.set(1842);
1 * data.tick =>  w.wait; 
