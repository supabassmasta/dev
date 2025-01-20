1 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////////
161::ms => dur lg;

KIK kik;
kik.config(0.1 /* init Sin Phase */, 85 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (100.0, 20::ms);
kik.addFreqPoint (35.0, lg );

kik.addGainPoint (0.6, 2::ms);
kik.addGainPoint (0.3, 10::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, lg );
kik.addGainPoint (0.0, 15::ms); 

fun void KICK(string seq) {
TONE t;
t.reg( kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.26 * data.master_gain => t.gain;
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
fun void HAT(string seq) {
SEQ s;  //data.tick * 8 => s.max;  //
SET_WAV.DUBSTEP(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
seq => s.seq;
.3 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
s.no_sync();// s.element_sync(); //s.no_sync()
//s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STPADSR stpadsr;
stpadsr.set(1::ms /* Attack */, 8::ms /* Decay */, 0.4 /* Sustain */, 10::ms /* Sustain dur of Relative release pos (float)*/,  10::ms /* release */);
stpadsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stpadsr.connect(last $ ST, s.note_info_tx_o); stpadsr $ ST @=>  last;
//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
// stpadsr.keyOn(); stpadsr.keyOff(); 


//  STMIX stmix;
//  stmix.send(last, mixer);

1::samp => now; // let seq() be sporked to compute length
s.s.duration => now;
}

//spork ~ HAT("*4 sss___");
///////////////////////////////////////////////////////////////////////////////////////////////
fun void HAT2(string seq) {
SEQ s;  //data.tick * 8 => s.max;  //
SET_WAV.DUBSTEP(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
seq => s.seq;
.5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
s.no_sync();// s.element_sync(); //s.no_sync()
//s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STPADSR stpadsr;
stpadsr.set(1::ms /* Attack */, 8::ms /* Decay */, 0.7 /* Sustain */, 11* 10::ms /* Sustain dur of Relative release pos (float)*/,  10::ms /* release */);
stpadsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stpadsr.connect(last $ ST, s.note_info_tx_o); stpadsr $ ST @=>  last;
//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
// stpadsr.keyOn(); stpadsr.keyOff(); 


//  STMIX stmix;
//  stmix.send(last, mixer);

1::samp => now; // let seq() be sporked to compute length
s.s.duration => now;
}

//spork ~ HAT("*4 sss___");
///////////////////////////////////////////////////////////////////////////////////////////////
fun void SNARE(string seq) {
SEQ s;  //data.tick * 8 => s.max;  //
SET_WAV.DUBSTEP(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
seq => s.seq;
.5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
s.no_sync();// s.element_sync(); //s.no_sync()
//s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STPADSR stpadsr;
stpadsr.set(3::ms /* Attack */, 30::ms /* Decay */, 1.0 /* Sustain */, 3* 10::ms /* Sustain dur of Relative release pos (float)*/,  10::ms /* release */);
stpadsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stpadsr.connect(last $ ST, s.note_info_tx_o); stpadsr $ ST @=>  last;
//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
// stpadsr.keyOn(); stpadsr.keyOff(); 


//  STMIX stmix;
//  stmix.send(last, mixer);

1::samp => now; // let seq() be sporked to compute length
s.s.duration => now;
}

//spork ~ SNARE("*4 sss___");


//////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
fun void DNB(string seq, string lpf_seq, float g) {
  SEQ s;  //data.tick * 8 => s.max;  //
  SET_WAV.TRIBAL(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.gain("s", .17); // for single wav 
  s.gain("v", .5); // for single wav 
  s.gain("h", 1.1); // for single wav 
  s.gain("J", 0.7); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
  //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 


STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 2 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 
AUTO.freq(lpf_seq) => stfreelpfx0.freq; // CONNECT THIS 




  //  STMIX stmix;
  //  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ DNB("*8 h_hJ hJh_ hshs hsh_ ");


//////////////////////////////////////////////////////////////////////////////////////////////
fun void BLIPS(string seq) {
SEQ s;  //data.tick * 8 => s.max;  //
SET_WAV.BLIPS(s);  // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
seq => s.seq;
.2 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
s.no_sync();// s.element_sync(); //s.no_sync()
//s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STDIGIT dig;
dig.connect(last $ ST , 3::samp /* sub sample period */ , .01 /* quantization */);      dig $ ST @=>  last; 


//  STMIX stmix;
//  stmix.send(last, mixer);

1::samp => now; // let seq() be sporked to compute length
s.s.duration => now;
}

//spork ~ BLIPS("*4 sss___");


//////////////////////////////////////////////////////////////////////////////////////////////
class PSYBASSx extends SYNT{

    1 => own_adsr;
    

    inlet => PowerADSR padsrin => TriOsc s => LPF filter =>PowerADSR padsrout => outlet;   
    
    1.0 => s.width;

    .25 => padsrin.gain;
    padsrin.set(0::ms, data.tick  , .7 , 200::ms);
    padsrin.setCurves(.6, 7., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

    padsrout.set(1::ms, data.tick* 2/2, .000001 , 16 * 10::ms);
    padsrout.setCurves(.6, 2., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
        1.8 => s.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(1::ms, data.tick / 2 , .0000001, data.tick / 4);
    padsr.setCurves(.3, 2.0, .5);
    1.2 => filter.Q;
    48 => base.next;
    250 => variable.next;

    // ADSR Trigger
    //padsr.keyOn(); padsr.keyOff();

    // fun void auto_off(){
      //     data.tick / 4 => now;
      //     padsr.keyOff();
      // }
      // spork ~ auto_off();

      fun void filter_freq_control (){ 
            while(1) {
                    filter_freq.last() => filter.freq;
                          1::ms => now;
                              }
      } 
      spork ~ filter_freq_control (); 


            fun void on()  {padsr.keyOn(); padsrin.keyOn(); padsrout.keyOn(); 0.5 => s.phase;}  fun void off() {padsr.keyOff(); padsrin.keyOff(); padsrout.keyOff(); }  fun void new_note(int idx)  {   } 0 => own_adsr;
} 


fun void BASS0 (string seq) {
TONE t;
t.reg(PSYBASSx s0);   //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.3 * data.master_gain => t.gain;
t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 23* 10.0 /* freq */ , 1.1 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STOVERDRIVE stod;
stod.connect(last $ ST, 1.2 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

.8 => stod.gain;


//  STMIX stmix;
//  stmix.send(last, mixer);

1::samp => now; // let seq() be sporked to compute length
t.s.duration => now;
}

//spork ~ BASS0("}c *8 4103124801234 :8 ____ ____");
////////////////////////////////////////////////////////////////////////////////////////////
class synt1 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;

fun void  LOOPPWM  (){ 
  SinOsc sin0 =>  blackhole;
  6.0 => sin0.freq;
  0.12 => sin0.gain;

  while(1) {

    sin0.last()  + .5 =>  s.width;

     1::ms => now;
    //-------------------------------------------
  }
} 
spork ~ LOOPPWM();

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
}
fun void BASS1 (string seq) {
TONE t;
t.reg(synt1 s0);   //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.4 * data.master_gain => t.gain;
t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(9 * 10 /* Base */, 4 * 100 /* Variable */, 1.5 /* Q */);
stsynclpfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.4 /* Sustain */, .3 /* Relative Sustain dur */, 0.3 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 23* 10.0 /* freq */ , 1.1 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STGVERB stgverb;
stgverb.connect(last $ ST, .004 /* mix */, 1 * 11. /* room size */, 9 * 10::ms /* rev time */, 0.0 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);

1::samp => now; // let seq() be sporked to compute length
t.s.duration => now;
}

////////////////////////////////////////////////////////////////////////////////////////////
fun void  CHORUS_voice  (){ 
  LONG_WAV l;
  "../_SAMPLES/sakura/chorus.wav" => l.read;
  0.8 * data.master_gain => l.buf.gain;
  0 => l.update_ref_time;
  l.AttackRelease(0::ms, 0::ms);


  // BASS Start
  l.start(0::ms /* sync */ , 0  * data.tick  /* offset */ ,  0::ms /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

64 * data.tick => now;

} 
////////////////////////////////////////////////////////////////////////////////////////////
fun void  CHORUS_voice  (float g , float pan){ 
  LONG_WAV l;
  "../_SAMPLES/sakura/chorus.wav" => l.read;
  0.8 * data.master_gain => l.buf.gain;
  0 => l.update_ref_time;
  l.AttackRelease(0::ms, 0::ms);

g - pan => l.outl.gain;
g +  pan => l.outr.gain;


  // BASS Start
  l.start(0::ms /* sync */ , 0  * data.tick  /* offset */ ,  0::ms /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

  64 * data.tick => now;

} 


////////////////////////////////////////////////////////////////////////////////////////////
fun void  CHORUS_DOUBLE_voice  (int i){ 

  .3 => float p; // pan
while(i) {
  spork ~   CHORUS_voice(0.5 /* gain */, p /* pan */); 
  -1 *=> p;
  1 -=> i;
  16 * data.tick => now;
}
 

64 * data.tick => now;

} 

126 => data.bpm;   (60.0/data.bpm)::second => data.tick;
48 => data.ref_note;

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
//8 *data.tick => w.fixed_end_dur;
4*data.tick => w.sync_end_dur;
//2 * data.tick =>  w.wait; 

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

// LOOP
////////////////////////////////////////////////////////////////////////////////////////////
fun void  LOOP_CHORUS_BASS1  (){ 

  spork ~ BASS1("{c *4  !5555 5555 5555 5___ 6666 6___ ____ ____  !5555 555_ 5__5 __5_ 66__ ____ ____ ____");

  spork ~ KICK("*2 1___ ____ ___1 ___1 ");
  spork ~ HAT("*4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  spork ~ BLIPS("*4 ____ __v_ ____   ____ ____ ____  __*8cccc cccc:8_     ____ ____ __e_ ");
  8 * data.tick =>  w.wait; 
  spork ~ KICK("*2 1___ ____ ___1 __1_");
  spork ~ HAT("4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_ ");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  8 * data.tick =>  w.wait; 

  spork ~ BASS1("{c *4 !555_ ___5 !666_ ____ 7!6!7!5 __7_ 666_ ____ 5555 ____6666!5555 !3333 ____ ____ ____ ");

  spork ~ KICK("*2 1___ ____ ___1 ___1 ");
  spork ~ HAT("*4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  spork ~ BLIPS("*4 ____ __v_ ____   ____ ____ ____  __*8cccc cccc:8_     ____ ____ __e_ ");
  8 * data.tick =>  w.wait; 
  spork ~ KICK("*2 1___ ____ ___1 __1_");
  spork ~ HAT("4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_ ");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  8 * data.tick =>  w.wait; 

  spork ~ BASS1("{c *4 2222 222_ 0000 000_ 2__2 __2_ 3333 3___ 2222 __2_ 0000  000_ A__A __AA AAAA A___ ");

  spork ~ KICK("*2 1___ ____ ___1 ___1 ");
  spork ~ HAT("*4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  spork ~ BLIPS("*4 ____ __v_ ____   ____ ____ ____  __*8cccc cccc:8_     ____ ____ __e_ ");
  8 * data.tick =>  w.wait; 
  spork ~ KICK("*2 1___ ____ ___1 __1_");
  spork ~ HAT("4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_ ");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  8 * data.tick =>  w.wait; 

  spork ~ BASS1("{c *42222 222_ 0000 0_0_ 2__2 __2_ 3333 3___ 2222 __2_ 0__0  __0_ A__A __A!0 !A!0!A_ A___ ");

  spork ~ KICK("*2 1___ ____ ___1 ___1 ");
  spork ~ HAT("*4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  spork ~ BLIPS("*4 ____ __v_ ____   ____ ____ ____  __*8cccc cccc:8_     ____ ____ __e_ ");
  8 * data.tick =>  w.wait; 
  spork ~ KICK("*2 1___ ____ ___1 __1_");
  spork ~ HAT("4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_ ");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  8 * data.tick =>  w.wait; 
}
////////////////////////////////////////////////////////////////////////////////////////////
fun void  LOOP_CHORUS_BASS0  (){ 

  spork ~ BASS0("*2555!6:2!7!9 !aaa_ *4e!e_e:4!d!c!a !9!7!6_");

  spork ~ KICK("*2 1___ ____ ___1 ___1 ");
  spork ~ HAT("*4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  spork ~ BLIPS("*4 ____ __v_ ____   ____ ____ ____  __*8cccc cccc:8_     ____ ____ __e_ ");
  8 * data.tick =>  w.wait; 
  spork ~ KICK("*2 1___ ____ ___1 __1_");
  spork ~ HAT("4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_ ");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  8 * data.tick =>  w.wait; 

  spork ~ BASS0("*2555!6:2!7!9 !a!c!d_ e!d*4!c!c_c:4!a *2!9!7!9!7!6!5!6!5:2");

  spork ~ KICK("*2 1___ ____ ___1 ___1 ");
  spork ~ HAT("*4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  spork ~ BLIPS("*4 ____ __v_ ____   ____ ____ ____  __*8cccc cccc:8_     ____ ____ __e_ ");
  8 * data.tick =>  w.wait; 
  spork ~ KICK("*2 1___ ____ ___1 __1_");
  spork ~ HAT("4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_ ");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  8 * data.tick =>  w.wait; 

  spork ~ BASS0("*2555!6:2!7!9 !aaa_ *4e!e_e:4!d!c!a !9!7!6_");

  spork ~ KICK("*2 1___ ____ ___1 ___1 ");
  spork ~ HAT("*4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  spork ~ BLIPS("*4 ____ __v_ ____   ____ ____ ____  __*8cccc cccc:8_     ____ ____ __e_ ");
  8 * data.tick =>  w.wait; 
  spork ~ KICK("*2 1___ ____ ___1 __1_");
  spork ~ HAT("4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_ ");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  8 * data.tick =>  w.wait; 

  spork ~ BASS0("*2555!6:2!7!9 !aaa_ *4e!e_e:4!d!c!a !9!7!6_");
  
  spork ~ KICK("*2 1___ ____ ___1 ___1 ");
  spork ~ HAT("*4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  spork ~ BLIPS("*4 ____ __v_ ____   ____ ____ ____  __*8cccc cccc:8_     ____ ____ __e_ ");
  8 * data.tick =>  w.wait; 
  spork ~ KICK("*2 1___ ____ ___1 __1_");
  spork ~ HAT("4}5 hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_hh_h __j_ __hj __h_ j_*8hhhhhhhh:8_ ");
  spork ~ SNARE("*2 ____ }2 t___ ____ }2 t__v");
  8 * data.tick =>  w.wait; 

} 

fun void  LOOPLAB  (){ 
  while(1) {
  spork ~   DNB  ("*4__h_ ____ _sh_ ___J h_sJ hs__ hs__ __h_ ___s    __hh ___s hsh_ _J_J hssJ hs_s hshs shh_ *4 s!h!s!h!s!h!s!h", "}c z/ff/zz/f", .4); 
  spork ~ KICK("*2  1___ ___1 ___1 ____   1___ ____ 1__1 1");
  spork ~ SNARE("*2 ____ t___ ____ t___   ____ t___ ____ ____");
  spork ~ HAT2("*2  __i_ __i_ ____ __i_   ____ __i_ _ii_ ____ ");
 16 * data.tick =>  w.wait; 
  spork ~   DNB  ("*4__h_ ____ _sh_ ___J h_sJ hs__ hs__ __h_ ___s    __hh ___s hsh_ _J_J hssJ hs_s hshs shh_ *4 s!s!s!s!s!s!s!s", "}c z/ff/zz/f", .4); 
  spork ~ KICK("*2  1___ ___1 1__1 ____   1_1_ ____ 1__1 1!1");
  spork ~ SNARE("*2 ____ t___ ____ t___   ____ t___ ____ ____");
  spork ~ HAT2("*2  __i_ __i_ __i_ __i_   __i_ __i_ _ii_ ____ ");
 16 * data.tick =>  w.wait; 
  spork ~   DNB  ("*4__h_ ____ _sh_ ___J h_sJ hs__ hs__ __h_ ___s    __hh ___s hsh_ _J_J hssJ hs_s hshs shh_ __ss", "}c z/ff/zz/f", .4); 
  spork ~ KICK("*2  1___ ____ 1__1 ____   1_1_ ____ 1__1 ____");
  spork ~ SNARE("*2 ____ t___ ____ t___   ____ t___ ____ t__v");
  spork ~ HAT2("*2  __i_ __ii __i_ __i_   __i_ __i_ _ii_ __i_ ");
 16 * data.tick =>  w.wait; 
  spork ~   DNB  ("*4__h_ ____ _sh_ ___J h_sJ hs__ hs__ __h_ ___s    __hh ___s hsh_ _J_J hssJ hs_s hshs shh_ __ss", "}c z/ff/zz/f", .4); 
  spork ~ KICK("*2  1___ ___1 1__1 1___   1_1_ ____ 1__1 __*21!1!1!1");
  spork ~ SNARE("*2 ____ t___ ____ _t__   ____ t___ ____ ____");
  spork ~ HAT2("*2  __i_ __i_ __i_ __i_   __i_ __i_ _ii_ ____ ");
 16 * data.tick =>  w.wait; 


    //-------------------------------------------
  }
} 
//spork ~ LOOPLAB();
LOOPLAB(); 

/********************************************************/
if (    0     ){
}/***********************   MAGIC CURSOR *********************/
while(1) { /********************************************************/

spork ~ CHORUS_DOUBLE_voice (3); 
//spork ~ CHORUS_voice (); 
spork ~ LOOP_CHORUS_BASS1 ();
64 * data.tick => w.wait;
spork ~ LOOP_CHORUS_BASS1 ();
64 * data.tick => w.wait;

} 



// 7 * data.tick =>  w.wait; sy.sync(4 * data.tick);

