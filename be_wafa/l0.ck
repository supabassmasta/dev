1 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////////
KIK kik;
kik.config(0.1 /* init Sin Phase */, 18 * 100 /* init freq env */, 0.5 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 6 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 6 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 

fun void KICK(string seq) {
  TONE t;
  t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .51 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
//spork ~ KICK("*4 k___ k___ k___ k___");
///////////////////////////////////////////////////////////////////////////////////////////////
fun void KICK(string seq, int mix) {
  TONE t;
  t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .51 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, mix);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
//spork ~ KICK("*4 k___ k___ k___ k___");
///////////////////////////////////////////////////////////////////////////////////////////////
KIK kik2;
kik2.config(0.1 /* init Sin Phase */, 45 * 100 /* init freq env */, 0.5 /* init gain env */);
kik2.addFreqPoint (433.0, 2::ms);
kik2.addFreqPoint (150.0, 16::ms);
   
kik2.addGainPoint (0.6, 13::ms);
kik2.addGainPoint (0.4, 25::ms);
kik2.addGainPoint (0.0, 15::ms); 

fun void KICK2(string seq) {
  TONE t;
  t.reg( kik2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .51 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
//spork ~ KICK("*4 k___ k___ k___ k___");


///////////////////////////////////////////////////////////////////////////////////////////////
fun void KICK2(string seq, int mix) {
  TONE t;
  t.reg( kik2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .51 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
  //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

STMIX stmix;
stmix.send(last, mix);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}
//spork ~ KICK("*4 k___ k___ k___ k___");


///////////////////////////////////////////////////////////////////////////////////////////////
fun void SEQ0(string seq) {
  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
  //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

  //  STMIX stmix;
  //  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ SEQ0("*4 sss___");

//////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
fun void SEQ0(string seq, dur cut, dur r, int mix, float g) {
  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
  //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

  STADSR stadsr;
  stadsr.set(0::ms /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, cut /* Sustain dur of Relative release pos (float) */,  r /* release */);
  stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
  //stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
  // stadsr.keyOn(); stadsr.keyOff(); 

    STMIX stmix;
    stmix.send(last, mix);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ SEQ0("*4 sss___");

//////////////////////////////////////////////////////////////////////////////////////////////
fun void SEQ0RATE(string seq, float r, int mix, float g) {
  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
  //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
  r => s.wav_o["T"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

    STMIX stmix;
    stmix.send(last, mix);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ SEQ0("*4 sss___");
//////////////////////////////////////////////////////////////////////////////////////////////
fun void SEQ1RATE(string seq, string c, float r, int mix, float g) {
  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
  //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
  r => s.wav_o[c].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

    STMIX stmix;
    stmix.send(last, mix);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ SEQ0("*4 sss___");

//////////////////////////////////////////////////////////////////////////////////////////////
class synt0 extends SYNT{
  inlet => SinOsc s =>  outlet; 
  .5 => s.gain;
  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


fun void SYNT0 (string seq) {
  TONE t;
  t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .3 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  //  STMIX stmix;
  //  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//spork ~ SYNT0("}c *8 4103124801234 :8 ____ ____");

////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAV  (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer);
   
   g => s.gain;

   file => s.read;

   s.length() => now;
} 

//   spork ~   SINGLEWAV("../_SAMPLES/", .4); 

////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAV  (string file, dur d, dur offset, dur a, dur r, int mix, float g){ 
  ST st; st $ ST @=> ST @ last;
  SndBuf s => st.mono_in;

  STADSR stadsr;
  stadsr.set(a /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, .0 /* Sustain dur of Relative release pos (float) */,  r /* release */);
  //   stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
  //stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
  stadsr.keyOn(); 

  STMIX stmix;
  stmix.send(last, mix);

  g => s.gain;

  file => s.read;
  ( offset / 1::samp ) $ int => s.pos;

  if(d == 0::ms) 
    s.length() => now;
  else
    d => now;

  stadsr.keyOff(); 
  r => now;
} 

//   spork ~   SINGLEWAV("../_SAMPLES/", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  .4); 

////////////////////////////////////////////////////////////////////////////////////////////

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

//   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .8,  .4); 


////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAVRATEECHO  (string file, float r, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

   STECHO ech;
   ech.connect(last $ ST , data.tick * 4 / 4 , .8);  ech $ ST @=>  last; 
//   STMIX stmix;
//   stmix.send(last, mixer);

   r => s.rate;
   g => s.gain;

   file => s.read;

   12 * data.tick => now;
}

//spork ~   SINGLEWAVRATEECHO("../_SAMPLES/", 1.8, .6); 

/////////////////////////////////////////////////////////////////////////////////

fun void  RECKICK  (){ 
    spork ~ KICK("*4   k___ ", mixer); 
    spork ~ SEQ1RATE("*4  k___   ", "k",  0.91, mixer, 1.39 );

    STMIX stmix;
    //stmix.send(last, 11);
    stmix.receive(mixer); stmix $ ST @=> ST @ last; 

    240::ms => dur l;

    STADSR stadsr;
    stadsr.set(0::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, l /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
//    stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
    stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
     stadsr.keyOn(); 

    STREC strec;
    strec.connect(last $ ST, l + 10::ms, "kick_be_wafa.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  

   l => now;
    stadsr.keyOff(); 
    1 * data.tick => now;
  
} 

if ( !MISC.file_exist("kick_be_wafa.wav")  ){
   RECKICK(); 
}

fun void  RECSNR  (){ 
  spork ~ SEQ0RATE("*4 +9+9 T___ ", 0.91, mixer, .45 );
  spork ~ SEQ0RATE("*4 +9+9 T___ ", 1.05, mixer, .45 );
  spork ~ KICK2("*4         T___ ", mixer );

  STMIX stmix;
  //stmix.send(last, 11);
  stmix.receive(mixer); stmix $ ST @=> ST @ last; 

//STOVERDRIVE stod;
//stod.connect(last $ ST, 3.1 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 
//.6 => stod.gain;

  10 * 10::ms => dur l;

  STADSR stadsr;
  stadsr.set(0::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, l /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
  //    stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
  stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
  stadsr.keyOn(); 

  STREC strec;
  strec.connect(last $ ST, l + 10::ms, "snare_be_wafa.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  

  l => now;
  stadsr.keyOff(); 
  1 * data.tick => now;
  
} 

if ( !MISC.file_exist("snare_be_wafa.wav")  ){
   RECSNR(); 
}


////////////////////////////////////////////////////////////////////////////////////////////

fun void SEQDNB(string seq, int mix, float g) {
  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
  "kick_be_wafa.wav" => s.wav["K"];  // act @=> s.action["a"]; 
  "snare_be_wafa.wav" => s.wav["S"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
  //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, mix);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ SEQDNB("*4 k___ s___ __k_ s___", mixer, 1.);

//////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

//data.bpm => data.bpm;   (60.0/data.bpm)::second => data.tick;
//data.ref_note => data.ref_note;

SYNC sy;
sy.sync(1 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

fun void  BEAT_COUNTER  (){ 
  1 => int i;
    while(1) {
      <<<"-------------------">>>;
      <<<"-        " + i + "        -">>>;
      <<<"-------------------">>>;
      1 +=> i;
      data.tick => now;
    }
} 

spork ~   BEAT_COUNTER (); 



WAIT w;
//8 *data.tick => w.fixed_end_dur;
1*data.tick => w.sync_end_dur;
//2 * data.tick =>  w.wait; 

// OUTPUT

7. => float CHASS_GAIN;

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

//////////////////////////////////////////////////////////////////////////////////
fun void  SCAT0   (){ 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", .75 * data.tick/* d */, 8 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   0.75 * data.tick => now;  
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", .75 * data.tick/* d */, 8 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   0.75 * data.tick => now;  
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", 1.0 * data.tick/* d */, 8 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   1.0 * data.tick => now;  
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", .75 * data.tick/* d */, 8 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   0.75 * data.tick => now;  
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", .75 * data.tick/* d */, 8 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   0.75 * data.tick => now;  
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", .5 * data.tick/* d */, 8 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   0.5 * data.tick => now;  
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", .5 * data.tick/* d */, 8 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   0.5 * data.tick => now;  
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", .5 * data.tick/* d */, 8 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   0.5 * data.tick => now;  
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", 2 * data.tick/* d */, 8 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   2.0 * data.tick => now;  
} 

fun void  LOOPLAB  (){ 
  while(1) {

//    spork ~   RECKICK (); 
//    .5 * data.tick => w.wait;
//    spork ~   RECSNR (); 
//    .75 * data.tick => w.wait;
////    spork ~   RECKICK (); 
//    .25 * data.tick => w.wait;
//    spork ~   RECSNR (); 
//    .5 * data.tick => w.wait;
spork ~   SCAT0 (); 

spork ~ SEQDNB("*4  K___ S___ __K_ S___  K___ S___ __K_ S___ ", mixer, 3.3);
spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ j_h_ h___ h_j_ ", 45::ms, 3::ms, mixer, 1.3);

    
    8 * data.tick => w.wait;
    //-------------------------------------------
  }
} 
//spork ~ LOOPLAB();
//LOOPLAB(); 

// LOOP
/********************************************************/
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/
  //spork ~ KICK("*4 k___ k___ k___ k___");
  //spork ~ SEQ0("____ *4s__s _ab_ ");
  //spork ~ SYNT0("}c *8 4103124801234 :8 ____ ____");
//spork ~ SEQ0("*4 +9+9 __T_ __T_ __T_ __T_ __T_ __T_ __T_ __T_  " );

//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", 0::ms /* d */, 8 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", 0::ms /* d */, 40 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", 0::ms /* d */, 56 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", 0::ms /* d */, 88 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 

   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", 32 * data.tick /* d */, 8 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
//spork ~ SEQDNB("*4  K___ S___ __K_ S___  K___ S___ __K_ S___ ", mixer, 3.3);
//spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ j_h_ h___ h_j_ ", 45::ms, 3::ms, mixer, 1.3);
//spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ jih_ h__h h_j_ ", 45::ms, 3::ms, mixer, 1.3);

//spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
//spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 
spork ~ SEQDNB("*4  ____ ____ ____ ____  ____ ____ __KK S_K_ ", mixer, 3.3);
//spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ j_h_ h___ h_j_ ", 45::ms, 3::ms, mixer, 1.3);
//spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ jih_ h__h h_j_ ", 45::ms, 3::ms, mixer, 1.3);

//spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
//spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
 spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 
spork ~ SEQDNB("*4  K___ S___ __K_ S___  K___ S___ __K_ S___ ", mixer, 3.3);
spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ j_h_ h___ h_j_ ", 45::ms, 3::ms, mixer, 1.3);
//spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ jih_ h__h h_j_ ", 45::ms, 3::ms, mixer, 1.3);

//spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
//spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 
 spork ~ SEQDNB("*4  K___ K___ K___ K___  K_K_ K_K_ KKKK*2  KKKK KKKK", mixer, 3.3);
//spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ j_h_ h___ h_j_ ", 45::ms, 3::ms, mixer, 1.3);
//spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ jih_ h__h h_j_ ", 45::ms, 3::ms, mixer, 1.3);

//spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
//spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 


   //////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//}/***********************   MAGIC CURSOR *********************/
//while(1) { /********************************************************/

   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/voix.wav", 0 * data.tick /* d */, 40 * data.tick /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 

spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 
spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 
spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 
spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 

// HIPHOP
spork ~ SEQDNB("*4  K___ S___ __K_ S___  K___ S___ __K_ S___ ", mixer, 3.3);
spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ j_h_ h___ h_j_ ", 45::ms, 3::ms, mixer, 1.3);
//spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ jih_ h__h h_j_ ", 45::ms, 3::ms, mixer, 1.3);

//spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
//spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 
spork ~ SEQDNB("*4  K___ S___ __K_ S___  K___ S___ __K_ S___ ", mixer, 3.3);
spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ j_h_ h___ h_j_ ", 45::ms, 3::ms, mixer, 1.3);
//spork ~ SEQ0("*8  __h_ i_h _ ____ h___ __h_ i_h_ h_i_ h___ h___ h_i_ h_j_h_i_h___ jih_ h__h h_j_ ", 45::ms, 3::ms, mixer, 1.3);

//spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
//spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 

//} if ( 0  ){
    
//////////////////////////////////////////////////////////////////////////

   for (0 => int i; i < 13      ; i++) {
spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 
spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 
spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 
spork ~ SEQDNB("*8  K___ S___ __K_ S___  K___ S___ __K_ S___ K___ S___ __K_ S___  K_K_ S___ __K_ S___", mixer, 3.3);
spork ~ SEQ0("*8 +7 h_h_ h_h +9s h_h_ h_h_ h_h_ h_hs hsh_h_h_h_h_ h_hs h_h_h_h_hsh_ h_hs hsh_ h_h_ ", 45::ms, 3::ms, mixer, .5);
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/dohl.wav", 8 * data.tick /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */, 1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/bass.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/sub.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
//   spork ~   SINGLEWAV("../_SAMPLES/be_wafa/violon ensemble.wav", 0::ms /* d */, 0::ms /* offset */, 1::ms /* a */, 1::ms /* r */, mixer /* mix */,  1. * CHASS_GAIN); 
   8 * data.tick =>  w.wait; 

   }



  // 7 * data.tick =>  w.wait; sy.sync(4 * data.tick);
}  


//SndBuf s;
//"../_SAMPLES/be_wafa/bass.wav" => s.read;

// <<<"bpm ",8 * 60::second / (  s.length() )>>>;
// <<<"bpm ",8 * 60::second / (  5.106::second )>>>;

