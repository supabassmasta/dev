16 => int mixer;

KIK kik;
kik.config(0.1 /* init Sin Phase */, 24 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 13 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 13 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 

fun void KICK3(string seq) {

TONE t;
t.reg(kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.33 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STDUCKMASTER duckm;
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 4::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void KICK3_HPF(string seq, string hpfseq) {

TONE t;
t.reg(kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.33 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STDUCKMASTER duckm;
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 4::ms /* Release */ );      duckm $ ST @=>  last; 

STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.3 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 





  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

//////////////////////////////////////////////////////////////////////////////////////////////


class SERUM00X extends SYNT{

  inlet => Gain factor => Phasor p => Wavetable w =>  outlet; 
  .5 => w.gain;
  .5 => factor.gain;

  1. => p.gain;

  1 => w.sync;
  1 => w.interpolate;
  //[-1.0, -0.5, 0, 0.5, 1, 0.5, 0, -0.5] @=> float myTable[];
  //[-1.0,  1] @=> float myTable[];
  float myTable[0];

  SndBuf s => blackhole;
  

  fun void config(int wn /* wave number */) {



  list_SERUM0.get(wn) => string wstr;
    
   if ( wstr == ""  ){
    list_SERUM0.get(0) => wstr;
   }
   else {
      <<<"serum wavtable :", wn, wstr>>>;
   }

   wstr => s.read;


    0 => int start;

    for (start => int i; i < s.samples() ; i++) {
      myTable << s.valueAt(i);
    }

    if ( myTable.size() == 0  ){
       <<<" SERUM ERROR: Empty wavtable !!!!!">>>;

       myTable << 0; 
    }

    w.setTable (myTable);
  }

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.2 =>p.phase; } 1 => own_adsr;
} 

fun void BASS0 (string seq) {
TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2212 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(15 * 10 /* Base */, 33 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 26*  .01/* Relative Decay */, 0.6 /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,75 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.4 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 9* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 


  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

fun void BASS0_HPF (string seq, string hpfseq) {
TONE t;
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2212 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .8, 40::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(15 * 10 /* Base */, 33 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0002 /* Relative Attack */, 26*  .01/* Relative Decay */, 0.6 /* Sustain */, .3 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,75 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, -0.4 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 9* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

STFREEFILTERX stfreehpfx0; HPF_XFACTORY stfreehpfx0_fact;
stfreehpfx0.connect(last $ ST , stfreehpfx0_fact, 1.0 /* Q */, 1 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreehpfx0 $ ST @=>  last; 
AUTO.freq(hpfseq) => stfreehpfx0.freq; // CONNECT THIS 



  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}




fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.TRANCE(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 SEQ s3; SET_WAV.TRIBAL(s3);
// s3.wav["s"] => s.wav["S"];  // act @=> s.action["a"]; 
// s3.wav["U"] => s.wav["S"];  // act @=> s.action["a"]; 
  seq => s.seq;
  .8 * data.master_gain => s.gain; //
  s.gain("s", 1.4); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // 
//   1.1 => s.wav_o["S"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

//  STDUCKMASTER duckm;
//  duckm.connect(last $ ST, 6. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

//  STMIX stmix;
//  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}


//spork ~  TRANCEBREAK ("*4 L___ L_L_ LLLL *2 LLLL LLLL"); 

class syntBass extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SawOsc s[synt_nb];
Gain final => outlet; .8 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    0.9 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    2. => detune[i].gain;    .5 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
    0 => s[0].phase;
    0 => s[1].phase;
          } 1 => own_adsr;
} 


fun void DIST (string seq) {
  TONE t;
  t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.add(27 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.01 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 0.98 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 2. /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 2 /* rank */ , 0.2 /* GAIN */, 3. /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  // s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
//  s0.config(11 /* synt nb */ , 2 /* rank */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .28 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


//////////////////////////////////////////////////////////////////////////////////
fun void DISTMOD (string seq) {
  TONE t;
  t.reg(SERUM1 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.add(27 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.01 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 0.98 /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 2. /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  s0.add(27 /* synt nb */ , 2 /* rank */ , 0.2 /* GAIN */, 3. /* in freq gain */,  3::ms /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3::ms /* release */ );
  // s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
//  s0.config(11 /* synt nb */ , 2 /* rank */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .32 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  // MOD ////////////////////////////////

  STMIX stmix;
  stmix.send(last, mixer + 1);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


//////////////////////////////////////////////////////////////////////////////////
fun void SUPERHIGH (string seq) {
  TONE t;
  t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(2 /* synt nb */ );
  // s0.set_chunk(0); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .40 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, 40* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


  // MOD ////////////////////////////////

//   SinOsc mod => SinOsc s => OFFSET o => s0.inlet;
//   1::second / (13 * data.tick) => s.freq;
//   //   0 => s.phase;
//   Std.rand2f(0, 1) => s.phase;
//   0.2 => mod.freq;
// 
//   1.2 => o.offset;
//   5.7 => o.gain;
// 
///   ARP arp;
///   arp.t.dor();
///  // 50::ms => arp.t.glide;
///   "*8  1/8 1/3 8/1 1/8  " => arp.t.seq;
///   arp.t.go();   
///  
///  // CONNECT SYNT HERE
///  3 => s0.inlet.op;
///  arp.t.raw() => s0.inlet; 


  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 



  1::samp => now; // let seq() be sporked to compute length
  t.s.duration + now => time target;
  [ 40 , 12 ,18 ] @=> int ar[]; // 12 18
  while(now < target) {
      s0.set_chunk(ar[Std.rand2(0, ar.size() - 1)]); 
        .5 * data.tick => now;
    }
}


//////////////////////////////////////////////////////////////////////////////////


fun void LEAD (string seq, int nb, float g) {
  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(nb /* synt nb */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  g * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 


  ADSRMOD adsrmod; // Direct ADSR freq input modulation
  adsrmod.adsr_set(0.1 /* relative attack dur */, 0.1 /* relative decay dur */ , 1.0 /* sustain */, - 0.5 /* relative release pos */, .3 /* relative release dur */);
  adsrmod.padsr.setCurves(1., 1., 2.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
  adsrmod.connect(s0 /* synt */, t.note_info_tx_o /* note info TX */); 

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


//////////////////////////////////////////////////////////////////////////////////




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
////////////////////////////////////////////////////////////////////////////////////////////
fun void  SLIDENOISE  (float fstart, float fstop, dur d, float width, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  NOISE3 s => ADSR a => st.mono_in;
   fstart => e0.value;
   fstop => e0.target;
   d => e0.duration ;// => now;
   
   1.0 => stp0.next;
   
   g => s.gain;
//   width => s.width;

   a.set(attackRelease, 0::ms, 1., attackRelease);

   a.keyOn();

   d => now;

   a.keyOff();
   attackRelease => now;
    
} 




////////////////////////////////////////////////////////////////////////////////////////////

fun void  SLIDESERUM1  (float fstart, float fstop, dur d, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  SERUM1 s0 => st.mono_in;
   s0.add(22 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
   s0.add(9 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 

  SinOsc sin0 => MULT m =>  s0;
  e0 => m;
  13.0 => sin0.freq;
  6.0 => sin0.gain;



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


//////////////////////////////////////////////////////////////////////////////////////////////////

fun void  MODU6 (int nb, string seq, string modf, string modg, float cut, float g){ 
   
TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(nb /* synt nb */ ); 
//t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
t.lyd();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
g * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


AUTO.freq(modf) =>  SinOsc sin0 => MULT m => s0.inlet;
AUTO.freq(modg) =>  m;


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(87 /* Base */, 50 * 100 /* Variable */, 3. /* Q */);
stsynclpfx0.adsr_set(.051 /* Relative Attack */, .5/* Relative Decay */, 0.1 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.4, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

//STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//stlpfx0.connect(last $ ST ,  stlpfx0_fact, cut /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//STMIX stmix;
//stmix.send(last, mixer  + 0);

//STREVAUX strevaux;
//strevaux.connect(last $ ST, .11 /* mix */); strevaux $ ST @=>  last;  
STMIX stmix;
stmix.send(last, mixer + 1 );

1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////

// MOD LEAD
TriOsc tri0 => /* MULT m => */ Gain modLead;
83.0 => tri0.freq;
14.0 => tri0.gain;
0.5 => tri0.width;

//SinOsc sin0 =>  m;
//0.1 => sin0.freq;
//1.0 => sin0.gain;


fun void MODLEAD (string seq, int nb) {
  TONE t;
  t.reg(SERUM0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  s0.config(nb /* synt nb */ , 2 /* rank */ ); 
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  .15 * data.master_gain => t.gain;
  t.no_sync();// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

// MOD 
  modLead => s0.inlet;


ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
" 18F1818F811F81  " => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

//  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
//  stlpfx0.connect(last $ ST ,  stlpfx0_fact, 2* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

//  STAUTOFILTERX stautoresx0; LPF_XFACTORY stautoresx0_fact;
//  stautoresx0.connect(last $ ST ,  stautoresx0_fact, 3.0 /* Q */, 3 * 100 /* freq base */, 6 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


//////////////////////////////////////////////////////////////////////////////////

SYNC sy;
sy.sync(1 * data.tick);

0.8 => data.master_gain;

153 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
//1::samp => w.fixed_end_dur;

1*data.tick => w.sync_end_dur;


////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .4 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .03 /* mix */, 9 * 10. /* room size */, 3::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

STMIX stmix2;
stmix2.receive(mixer + 1); stmix2 $ ST @=>  last; 

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 2.6 /* Q */, 16 * 100 /* freq base */, 62 * 100 /* freq var */, data.tick * 24 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STREVAUX strevaux;
strevaux.connect(last $ ST, .1 /* mix */); strevaux $ ST @=>  last;  


fun void  LOOP_LAB  (){ 
  while(1) {

    spork ~   MODLEAD ("{c*4 " + RAND.seq("F///f,G//f,f//1,e/0", 1), 6 ); 
 
    spork ~   MODU6 (293, "*8  " + RAND.seq("1_1_,1_1_,1_1_,1_5_,8_1_,f___,f_1_", 16), "{0 }c G", "}c}c{3  f", 38 *100, .06); 
    spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
    spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
    spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
    4 * data.tick =>  w.wait;   
        
    spork ~  KICK3 ("*4 K___ K___ K___ K__K "); 
    spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
    spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
    4 * data.tick =>  w.wait;   
    spork ~   LEAD ("*4 " + RAND.seq("1__1_,1_1_,8__1_,f_8_,f_1_", 8)  , 3, .15); 
    spork ~   MODU6 (293, "*8  " + RAND.seq("1_1_,1_1_,1_1_,1_5_,8_1_,f___,f_1_", 16), "{0 }c G", "}c}c{3  f", 38 *100, .06); 
    spork ~  KICK3 ("*4 K___ K___ K___ K_K _"); 
    spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
    spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
    4 * data.tick =>  w.wait;   
    spork ~  KICK3 ("*4 K___ K___ K___ K_KK "); 
    spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
    spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
    4 * data.tick =>  w.wait;   
  } 
}
//LOOP_LAB();

///////////////////// PLAYBACK/REC /////////////////////////

0 => int compute_mode; // play song with real computing
0 => int rec_mode; // While playing song in compute mode, rec it

"LaBamboche_main.wav" => string name_main;
"LaBamboche_aux.wav" => string name_aux;
8 * data.tick => dur main_extra_time;
8 * data.tick => dur end_loop_extra_time;
1.0 => float aux_out_gain;
1 => int end_loop_rec_once;

if ( !compute_mode && MISC.file_exist(name_main) && MISC.file_exist(name_aux)  ){

    

    LONG_WAV l;
    name_main => l.read;
    1.0 * data.master_gain => l.buf.gain;
    0 => l.update_ref_time;
    l.AttackRelease(0::ms, 10::ms);
    l.start(0 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

    LONG_WAV l2;
    name_aux => l2.read;
    aux_out_gain * data.master_gain => l2.buf.gain;
    0 => l2.update_ref_time;
    l2.AttackRelease(0::ms, 10::ms);
    l2.start(0 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l2 $ ST @=>  last;  

    STREVAUX strevaux;
    strevaux.connect(last $ ST, 1. /* mix */); strevaux $ ST @=>  last;  

    // WAIT Main to finish
    l.buf.length() - main_extra_time  =>  w.wait;
    
    // END LOOP 
    ST stout;
  	SndBuf2 buf_end_loop_0; name_main+"_end_loop" => buf_end_loop_0.read; buf_end_loop_0.samples() => buf_end_loop_0.pos; buf_end_loop_0.chan(0) => stout.outl; buf_end_loop_0.chan(1) => stout.outr;
  	SndBuf2 buf_end_loop_1; name_main+"_end_loop" => buf_end_loop_1.read; buf_end_loop_1.samples() => buf_end_loop_1.pos; buf_end_loop_1.chan(0) => stout.outl; buf_end_loop_1.chan(1) => stout.outr;


  	SndBuf2 buf_end_loop_aux_0; name_aux+"_end_loop" => buf_end_loop_aux_0.read; buf_end_loop_aux_0.samples() => buf_end_loop_aux_0.pos; aux_out_gain => buf_end_loop_aux_0.gain;
  	SndBuf2 buf_end_loop_aux_1; name_aux+"_end_loop" => buf_end_loop_aux_1.read; buf_end_loop_aux_1.samples() => buf_end_loop_aux_1.pos; aux_out_gain => buf_end_loop_aux_1.gain;


    ST stauxout;
    buf_end_loop_aux_0.chan(0) => stauxout.outl;
    buf_end_loop_aux_0.chan(1) => stauxout.outr;

    buf_end_loop_aux_1.chan(0) => stauxout.outl;
    buf_end_loop_aux_1.chan(1) => stauxout.outr;

    strevaux.connect(stauxout $ ST, 1. /* mix */); strevaux $ ST @=>  last;  

    0 => int toggle;

    0 => data.next;

    while (!data.next) {

      <<<"**********">>>;
      <<<" END LOOP ">>>;
      <<<"**********">>>;

      if ( !toggle ) {
        1 => toggle;
        0 => buf_end_loop_0.pos;
        0 => buf_end_loop_aux_0.pos;
      } else {
        0 => toggle;
        0 => buf_end_loop_1.pos;
        0 => buf_end_loop_aux_1.pos;
          
      }
      
      // WAIT end loop to finish
      buf_end_loop_0.length() - end_loop_extra_time =>  w.wait;
    }

    // END
  	SndBuf2 buf_end_0; name_main+"_end" => buf_end_0.read; buf_end_0.samples() => buf_end_0.pos; buf_end_0.chan(0) => stout.outl; buf_end_0.chan(1) => stout.outr;

  	SndBuf2 buf_end_aux_0; name_aux+"_end" => buf_end_aux_0.read; buf_end_aux_0.samples() => buf_end_aux_0.pos; aux_out_gain => buf_end_aux_0.gain;
 
    buf_end_aux_0.chan(0) => stauxout.outl;
    buf_end_aux_0.chan(1) => stauxout.outr;
    
    0 => buf_end_0.pos;
    0 => buf_end_aux_0.pos;
    buf_end_0.length() =>  w.wait;
   
  }
else {


// REC  MAIN /////////////////////////////////////////     
  STREC strec;
  STREC strecaux;
  if (rec_mode) {     
    ST stmain; stmain $ ST @=>   last;
    dac.left => stmain.outl;
    dac.right => stmain.outr;

    strec.connect(last $ ST); strec $ ST @=>  last;  
    0 => strec.gain;
    strec.rec_start(name_main, 0::ms, 1);

    // REC AUX //////////////////////////////////////////
    ST staux; staux $ ST @=>   last;

    if ( MISC.check_output_nb() >= 4  ){
      // Rec out Aux
      dac.chan(2) => staux.outl;
      dac.chan(3) => staux.outr;
    } else {
      // rec Default reverb STREV1
      global_mixer.rev1_left => staux.outl;
      global_mixer.rev1_right => staux.outr;
    }

    /// START REC

    strecaux.connect(last $ ST); strecaux $ ST @=>  last;  

    strecaux.rec_start(name_aux, 0::ms, 1);
  }
//////////////////////////////////////////////////



 
// INTRO

    
 spork ~   SINGLEWAV("../_SAMPLES/bamboche/full.wav", .25); 
  9 * data.tick =>  w.wait;   
 spork ~   SINGLEWAV("../_SAMPLES/bamboche/maisfermetagueule.wav", .25); 
  4 * data.tick =>  w.wait;   


/********************************************************/


   spork ~   LEAD ("*2 1__1__1_ 1__1__1_ " , 0, .2); 
   spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
   spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 

   4 * data.tick =>  w.wait;   

//////////////////////////////
//} if  ( 0 ){
/////////////////////

  spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~   MODLEAD ("}c +2__*8 1_1_1_1_", 8 ); 
  spork ~   LEAD ("*2 1!1_1!1_1_ 1__ " , 0, .2); 
  spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   


  spork ~   MODLEAD ("{c__*4 1111", 4 ); 
  spork ~  KICK3 ("*4 K_K_ K_KK  "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh  "); 
  spork ~  BASS0        ("*4 __!8!1 __ "); 
  2 * data.tick =>  w.wait;   
  spork ~   SINGLEWAV("../_SAMPLES/bamboche/labamboche.wav", .25); 
   

  spork ~   MODLEAD ("{c__*4 F///f", 6 ); 
   spork ~   LEAD ("*2 1__1__1_ 1__1__1_ " , 3, .2); 
  spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   


  spork ~   MODLEAD ("{c__*4 1111", 6 ); 
  spork ~   LEAD ("*2 1_1_1_1_ 1__1__1_  " , 3, .2); 
  spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~  KICK3 ("*4 K_K_   "); 
  spork ~  TRANCEHH ("*4 +1 __h_   "); 
  spork ~  BASS0        ("*4 __ "); 
  1 * data.tick =>  w.wait;   
  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/RienAPeter.wav", .25); 
  3 * data.tick =>  w.wait;   


  spork ~   MODLEAD ("}c +0__*8 1_1_1_1_", 15 ); 
   spork ~   LEAD ("*4 1__1__1_ 1__1__1_ " , 8, .2); 
 spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~   MODLEAD ("{c__*4 F////f", 21 ); 
  spork ~  KICK3 ("*4 K___ K___ K___ K_K_ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~   MODLEAD ("}c +2__*8 1_1_1_1_", 17 ); 
  spork ~   LEAD ("*4 }c 1__1__1_ 1__1__1_1_1_ " , 8, .2); 
  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/RienAPeter_reduced.wav", .25); 
  spork ~  KICK3 ("*4 K___ K___ K___ KKKK "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   


  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/RienAPeter_reduced.wav", .25); 
  spork ~  KICK3 ("*4 K_K_ K_KK  "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh  "); 
  spork ~  BASS0        ("*4 __!1!1 __ "); 
  2 * data.tick =>  w.wait;   
  spork ~   SINGLEWAV("../_SAMPLES/bamboche/labamboche.wav", .25); 
   
  spork ~   MODLEAD ("__*4 88/11", 0); 
   spork ~   LEAD ("*4 }c 1_1_1_ 1__1__1_ 1_1_1_" , 8, .2); 
 spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   


  spork ~   MODLEAD ("__*8 8041149 5", 11 ); 
   spork ~   LEAD ("*4 }c 1__1__1_ 1__1__1_ 1__1__1_" , 11, .2); 
  spork ~   LEAD ("*2 1_1_1_1_ 1__1__1_  " , 3, .2); 
  spork ~  KICK3 ("*4 K___ K___ K__K K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~   MODLEAD ("__*8 813840145", 17 ); 
  spork ~  KICK3 ("*4 K_K_   "); 
  spork ~  TRANCEHH ("*4 +1 __h_   "); 
  spork ~  BASS0        ("*4 __ "); 
  1 * data.tick =>  w.wait;   
  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/RienAPeter.wav", .25); 
  3 * data.tick =>  w.wait;   

  spork ~   MODLEAD ("{c__*4 f////F", 21 ); 
 spork ~   LEAD ("*4 }c 1_1_1_ 1__1__1_ 1_1_1_ 1_" , 11, .2); 
  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/RienAPeter_reduced.wav", .25); 
  spork ~  KICK3 ("*4 K___ K___ K___ K__K "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   


  spork ~   MODLEAD ("{c__*8 8149 5041", 7 ); 
  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/RienAPeter_reduced.wav", .25); 
  spork ~  KICK3 ("*4 K_K_ K_KK  "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh  "); 
  spork ~  BASS0        ("*4 __!1!1!8!8!8!8  "); 
  2 * data.tick =>  w.wait;   

 //////////////////////////////////////////////////////////////////////////////////////////////////////
 
  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/CouvreFeu.wav", .25); 
  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  
                          k___ k___ k___ k___ k___ k___ k___ k___  
                          k___ k___ k___ k___ k___ k___ k___ k___  
                          k___ k___ k___ k___ k___ k___ k___ k___ k__ 
  
  ", ":8:2 M/ff/M" );
  spork ~  BASS0_HPF ("*4 __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 
                          __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 
                          __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 
                          __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 
  ", ":8:2 M/ff/M");
 38 * data.tick =>  w.wait;   

 //////////////////////////////////////////////////////////////////////////////////////////////////////
   spork ~   LEAD ("*2 1__1__1_ 1__1__1_ " , 0, .2); 
   spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
   spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
   spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 

   4 * data.tick =>  w.wait;   


  spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~   MODLEAD ("}c +2__*8 1_1_1_1_", 8 ); 
  spork ~   LEAD ("*2 1!1_1!1_1_ 1__ " , 0, .2); 
  spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   


  spork ~   MODLEAD ("{c__*4 1111", 4 ); 
  spork ~  KICK3 ("*4 K_K_ K_KK  "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh  "); 
  spork ~  BASS0        ("*4 __!8!1 __ "); 
  2 * data.tick =>  w.wait;   
  spork ~   SINGLEWAV("../_SAMPLES/bamboche/labamboche.wav", .25); 
   

  spork ~   MODLEAD ("{c__*4 F///f", 6 ); 
   spork ~   LEAD ("*2 1__1__1_ 1__1__1_ " , 3, .2); 
  spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   


  spork ~   MODLEAD ("{c__*4 1111", 6 ); 
  spork ~   LEAD ("*2 1_1_1_1_ 1__1__1_  " , 3, .2); 
  spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~  KICK3 ("*4 K_K_   "); 
  spork ~  TRANCEHH ("*4 +1 __h_   "); 
  spork ~  BASS0        ("*4 __ "); 
  1 * data.tick =>  w.wait;   
  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/RienAPeter.wav", .25); 
  3 * data.tick =>  w.wait;   


  spork ~   MODLEAD ("}c +0__*8 1_1_1_1_", 15 ); 
   spork ~   LEAD ("*4 1__1__1_ 1__1__1_ " , 8, .2); 
 spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~   MODLEAD ("{c__*4 F////f", 21 ); 
  spork ~  KICK3 ("*4 K___ K___ K___ K_K_ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~   MODLEAD ("}c +2__*8 1_1_1_1_", 17 ); 
  spork ~   LEAD ("*4 }c 1__1__1_ 1__1__1_1_1_ " , 8, .2); 
  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/RienAPeter_reduced.wav", .25); 
  spork ~  KICK3 ("*4 K___ K___ K___ KKKK "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   


  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/RienAPeter_reduced.wav", .25); 
  spork ~  KICK3 ("*4 K_K_ K_KK  "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh  "); 
  spork ~  BASS0        ("*4 __!1!1 __ "); 
  2 * data.tick =>  w.wait;   
  spork ~   SINGLEWAV("../_SAMPLES/bamboche/labamboche.wav", .25); 
   
  spork ~   MODLEAD ("__*4 88/11", 0); 
   spork ~   LEAD ("*4 }c 1_1_1_ 1__1__1_ 1_1_1_" , 8, .2); 
 spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   


  spork ~   MODLEAD ("__*8 8041149 5", 11 ); 
   spork ~   LEAD ("*4 }c 1__1__1_ 1__1__1_ 1__1__1_" , 11, .2); 
  spork ~   LEAD ("*2 1_1_1_1_ 1__1__1_  " , 3, .2); 
  spork ~  KICK3 ("*4 K___ K___ K__K K___ "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   

  spork ~   MODLEAD ("__*8 813840145", 17 ); 
  spork ~  KICK3 ("*4 K_K_   "); 
  spork ~  TRANCEHH ("*4 +1 __h_   "); 
  spork ~  BASS0        ("*4 __ "); 
  1 * data.tick =>  w.wait;   
  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/RienAPeter.wav", .25); 
  3 * data.tick =>  w.wait;   

  spork ~   MODLEAD ("{c__*4 f////F", 21 ); 
 spork ~   LEAD ("*4 }c 1_1_1_ 1__1__1_ 1_1_1_ 1_" , 11, .2); 
  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/RienAPeter_reduced.wav", .25); 
  spork ~  KICK3 ("*4 K___ K___ K___ K__K "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
  spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
  4 * data.tick =>  w.wait;   


  spork ~   MODLEAD ("{c__*8 8149 5041", 7 ); 
  spork ~   SINGLEWAV("../_SAMPLES/CouvreFeu/RienAPeter_reduced.wav", .25); 
  spork ~  KICK3 ("*4 K_K_ K_KK  "); 
  spork ~  TRANCEHH ("*4 +1 __h_ s_hh  "); 
  spork ~  BASS0        ("*4 __!1!1!8!8!8!8  "); 
  2 * data.tick =>  w.wait;   

 
  spork ~   SINGLEWAV("../_SAMPLES/bamboche/labamboche.wav", .25); 

  spork ~ SLIDENOISE  (200, 5000, 7 * data.tick ,.2 , .2);
  spork ~  KICK3 ("*4 K_K_ K_KK ____ ____ K___ K_K_ KKKK *2 KKKK KKKK :2 "); 
  
  8 * data.tick =>  w.wait;   
  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    main_extra_time =>  w.wait;  // Wait for Echoes REV to complete
    strec.rec_stop( 0::ms, 1);
    strecaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////
  
  0 => data.next;
  while(!data.next) {

<<<"***************">>>;
<<<"   END LOOP    ">>>;
<<<"***************">>>;

// REC  MAIN END LOOP /////////////////////////////////////////     
  STREC strecendloop;
  STREC strecendloopaux;
  if (rec_mode && end_loop_rec_once) {     
    ST stmain; stmain $ ST @=>   last;
    dac.left => stmain.outl;
    dac.right => stmain.outr;

    strecendloop.connect(last $ ST); strecendloop $ ST @=>  last;  
    0 => strecendloop.gain;
    strecendloop.rec_start(name_main +"_end_loop", 0::ms, 1);

    // REC AUX END LOOP //////////////////////////////////////////
    ST staux; staux $ ST @=>   last;

    if ( MISC.check_output_nb() >= 4  ){
      // Rec out Aux
      dac.chan(2) => staux.outl;
      dac.chan(3) => staux.outr;
    } else {
      // rec Default reverb STREV1
      global_mixer.rev1_left => staux.outl;
      global_mixer.rev1_right => staux.outr;
    }

    /// START REC

    strecendloopaux.connect(last $ ST); strecendloopaux $ ST @=>  last;  

    strecendloopaux.rec_start(name_aux + "_end_loop", 0::ms, 1);

    // As we are in rec mode, directly go out end loop
    1 => data.next;
  }
//////////////////////////////////////////////////

    spork ~   MODLEAD ("{c*4 " + RAND.seq("F///f,G//f,f//1,e/0", 1), 6 ); 
 
    spork ~   MODU6 (293, "*8  " + RAND.seq("1_1_,1_1_,1_1_,1_5_,8_1_,f___,f_1_", 16), "{0 }c G", "}c}c{3  f", 38 *100, .06); 
    spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
    spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
    spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
    4 * data.tick =>  w.wait;   
        
    spork ~  KICK3 ("*4 K___ K___ K___ K__K "); 
    spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
    spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
    4 * data.tick =>  w.wait;   
    spork ~   LEAD ("*4 " + RAND.seq("1__1_,1_1_,8__1_,f_8_,f_1_", 8)  , 3, .15); 
    spork ~   MODU6 (293, "*8  " + RAND.seq("1_1_,1_1_,1_1_,1_5_,8_1_,f___,f_1_", 16), "{0 }c G", "}c}c{3  f", 38 *100, .06); 
    spork ~  KICK3 ("*4 K___ K___ K___ K_K _"); 
    spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
    spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
    4 * data.tick =>  w.wait;   
    spork ~  KICK3 ("*4 K___ K___ K___ K_KK "); 
    spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
    spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
    4 * data.tick =>  w.wait; 

    spork ~   MODLEAD ("{c*4 " + RAND.seq("F///f,G//f,f//1,e/0", 1), 6 ); 
 
    spork ~   MODU6 (293, "*8  " + RAND.seq("1_1_,1_1_,1_1_,1_5_,8_1_,f___,f_1_", 16), "{0 }c G", "}c}c{3  f", 38 *100, .06); 
    spork ~  KICK3 ("*4 K___ K___ K___ K___ "); 
    spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
    spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
    4 * data.tick =>  w.wait;   
        
    spork ~  KICK3 ("*4 K___ K___ K___ K__K "); 
    spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
    spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
    4 * data.tick =>  w.wait;   
    spork ~   LEAD ("*4 " + RAND.seq("1__1_,1_1_,8__1_,f_8_,f_1_", 8)  , 3, .15); 
    spork ~   MODU6 (293, "*8  " + RAND.seq("1_1_,1_1_,1_1_,1_5_,8_1_,f___,f_1_", 16), "{0 }c G", "}c}c{3  f", 38 *100, .06); 
    spork ~  KICK3 ("*4 K___ K___ K___ K_K _"); 
    spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
    spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
    4 * data.tick =>  w.wait;   
    spork ~  KICK3 ("*4 K___ K___ K___ K_KK "); 
    spork ~  TRANCEHH ("*4 +1 __h_ s_hh __h_ shhh "); 
    spork ~  BASS0        ("*4 __!1!1 __!1!1 __!1!1 __!1!1"); 
    4 * data.tick =>  w.wait;   
  //// STOP REC ///////////////////////////////
  if (rec_mode && end_loop_rec_once) {     
    end_loop_extra_time =>  w.wait;  // Wait for Echoes REV to complete
    strecendloop.rec_stop( 0::ms, 1);
    strecendloopaux.rec_stop( 0::ms, 1);
    0 => end_loop_rec_once;
    2::ms => now;
  
  }

  }

// END
// REC  MAIN END LOOP /////////////////////////////////////////     
  STREC strecend;
  STREC strecendaux;
  if (rec_mode) {
    ST stmain; stmain $ ST @=>   last;
    dac.left => stmain.outl;
    dac.right => stmain.outr;

    strecend.connect(last $ ST); strecend $ ST @=>  last;  
    0 => strecend.gain;
    strecend.rec_start(name_main +"_end", 0::ms, 1);
    // REC AUX END LOOP //////////////////////////////////////////
    ST staux; staux $ ST @=>   last;

    if ( MISC.check_output_nb() >= 4  ){
      // Rec out Aux
      dac.chan(2) => staux.outl;
      dac.chan(3) => staux.outr;
    } else {
      // rec Default reverb STREV1
      global_mixer.rev1_left => staux.outl;
      global_mixer.rev1_right => staux.outr;
    }

    /// START REC

    strecendaux.connect(last $ ST); strecendaux $ ST @=>  last;  

    strecendaux.rec_start(name_aux + "_end", 0::ms, 1);
  }
//////////////////////////////////////////////////


  spork ~  KICK3_HPF ("*4 k___ k___ k___ k___ k___ k___ k___ k___  
                          k___ k___ k___ k___ k___ k___ k___ k___ k___ 
  
  ", ":8:2 M/ff/M" );
  spork ~  BASS0_HPF ("*4 __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 
                          __1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 __!1!1 
  ", ":8:2 M/ff/M");
 18 * data.tick =>  w.wait;   

  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    // Note extra time to add above
    strecend.rec_stop( 0::ms, 1);
    strecendaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


}

