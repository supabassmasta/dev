10 => int mixer;
/////////////////////////////////////////////////////////////////////////////////////////

fun void TRANCE(string seq) {

  SEQ s;  
  SET_WAV.TRANCE(s); 
  
  // SET_WAV.TRANCE_KICK(s); 
  // s.wav["k"]=> s.wav["k"];
 
  
  seq => s.seq;
  .8 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

STOVERDRIVE stod;
stod.connect(last $ ST, 6.8 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 
.3 => stod.gain;

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}


//spork ~  TRANCE ("*4 L___ L_L_ LLLL *2 LLLL LLLL"); 
/////////////////////////////////////////////////////////
fun void TRANCEHH(string seq) {

  SEQ s;  
  SET_WAV.TRANCE(s); 
  
  // SET_WAV.TRANCE_KICK(s); 
  // s.wav["k"]=> s.wav["k"];
 
  
  seq => s.seq;
  .9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
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

////////////////////////////////////////////////////////////////////////////////////////////
fun void BASS (string seq) {
  TONE t;
  t.reg(PSYBASS0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .6 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STLPFN lpfn;
  lpfn.connect(last $ ST , 7 * 100 /* freq */  , 1.0 /* Q */ , 3 /* order */ );       lpfn $ ST @=>  last;  

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//spork ~ SIN("}c *8 4103124801234 :8 ____ ____");
/////////////////////////////////////////////////////////////////////////////////////////

fun void CHANT(string seq) {


SEQ s;  
"../_SAMPLES/IlesMarquises/NukuHivaDanseDuCochon/Ho.wav" => s.wav["a"];  // act @=> s.action["a"]; 
"../_SAMPLES/IlesMarquises/NukuHivaDanseDuCochon/He.wav" => s.wav["b"];  // act @=> s.action["a"]; 
"../_SAMPLES/IlesMarquises/NukuHivaDanseDuCochon/Hi.wav" => s.wav["c"];  // act @=> s.action["a"]; 
"../_SAMPLES/IlesMarquises/NukuHivaDanseDuCochon/Ho2.wav" => s.wav["A"];  // act @=> s.action["a"]; 
"../_SAMPLES/IlesMarquises/NukuHivaDanseDuCochon/He2.wav" => s.wav["B"];  // act @=> s.action["a"]; 
"../_SAMPLES/IlesMarquises/NukuHivaDanseDuCochon/Hi2.wav" => s.wav["C"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 seq => s.seq;
1.1 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();
  s.go();     s $ ST @=> ST @ last; 

   STMIX stmix;
   stmix.send(last, mixer );

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~  CHANT (" ab_c_ba_ AB_C_BA");
/////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////
fun void  SINGLEWAV  (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer + 2);
   
   g => s.gain;

   file => s.read;

   s.length() => now;
} 

//   spork ~   SINGLEWAV("../_SAMPLES/", .4); 
////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAVRATE  (string file, float r, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

   STMIX stmix;
   stmix.send(last, mixer);
   r => s.rate;
   g => s.gain;

   file => s.read;

   s.length() * (1./r) => now;
} 

//   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .8,  .4); 


////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////


147 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

SYNC sy;
//sy.sync(8 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
0::ms => w.fixed_end_dur;
//8*data.tick => w.sync_end_dur;
//2 * data.tick =>  w.wait; 

// OUTPUT
STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 14 * 10. /* room size */, 1::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

// INTRO

if ( 1  ){
    
  spork ~   SINGLEWAV("../_SAMPLES/IlesMarquises/NukuHivaDanseDuCochon/IntroHomme.wav", 0.8); 
  65 * data.tick =>  w.wait; 
  spork ~   SINGLEWAVRATE("../_SAMPLES/IlesMarquises/conque.wav", 1.0, 0.8); 
  10 * data.tick =>  w.wait;
}

// LOOP
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
 

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _1_1_1_1 _1_1_1_1 "); 
  spork ~  CHANT (" ab_c_ba_ AB_C_BA_");
  spork ~  CHANT (" AB_C_BA_ ab_c_ba_");

  16 * data.tick =>  w.wait; 

} 
 
