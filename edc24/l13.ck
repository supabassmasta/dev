21 => int mixer;



///////////////////////////////////////////////////////////////////////////////////////////////
KIK kik;
kik.config(0.1 /* init Sin Phase */, 19 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (250.0, 2::ms);
kik.addFreqPoint (96.0, 50::ms);
kik.addFreqPoint (31.0, 4 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 4 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 

fun void KICK3(string seq) {

TONE t;
t.reg(kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.28 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STDUCKMASTER duckm;
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 10::ms /* Release */ );      duckm $ ST @=>  last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration - 1::samp => now;
}


///////////////////////////////////////////////////////////////////////////////////////////////
class synt0 extends SYNT{

    inlet => Gain h1 => SawOsc s2 =>  outlet; 
      2 => h1.gain;
      .5 => s2.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
          0.0 => s2.phase;
          } 0 => own_adsr;
} 


class synt1 extends SYNT{

    inlet => SinOsc s =>  outlet; 
    inlet => Gain h1 => SawOsc s2 =>  outlet; 
      .0 => s.gain;
      2 => h1.gain;
      .5 => s2.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
          0.1 => s.phase;
          0.0 => s2.phase;
          } 0 => own_adsr;
} 




fun void BASS0 (string seq) {
TONE t;
//t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c" + seq => t.seq;
0.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(0::ms, 10::ms, 1, 4::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(10 * 10 /* Base */, 8 * 100 /* Variable */, 1.5 /* Q */);
stsynclpf.adsr_set(.0004 /* Relative Attack */, .25/* Relative Decay */, .3 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf.nio.padsr.setCurves(1.0, .4, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STADSR stadsr;
stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff();


STLPFN lpfn;
lpfn.connect(last $ ST , 5 * 100 /* freq */  , 1.0 /* Q */ , 3 /* order */ );       lpfn $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 



  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}

///////////////////////////////////////////////////////////////////////////////////////////////
fun void TRANCEHH(string seq) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //
  SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);//
   s.wav["U"]=> s.wav["u"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  .9 * data.master_gain => s.gain; //
  s.gain("u", 1.6); // for single wav 
  //s.sync(4*data.tick);// s.element_sync(); //
  s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate; // s.out("k") /* return ST */
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();   //  s $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

///////////////////////////////////////////////////////////////////////////////////////////////

class syntPAD extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
Step det_amount[synt_nb];
TriOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;
.1 => float w;
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; w => s[i].width;  i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -2.38 => det_amount[i].next;      .1 => s[i].gain; w => s[i].width;i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.32 => det_amount[i].next;      .1 => s[i].gain;w => s[i].width; i++;   

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


fun void PAD (int idx, string seq, float playback_gain) {
  "pad1sd_"+ idx + ".wav" => string name;
  if (  MISC.file_exist(name) ){
    ST st; st $ ST @=> ST @ last;
    SndBuf2 s;
    s.chan(0) => st.outl;
    s.chan(1) => st.outr;

    STMIX stmix;
    stmix.send(last, mixer);

    playback_gain * data.master_gain  => s.gain;

    name => s.read;

    s.length() => now;
  }
  else {
    TONE t;
    t.reg(syntPAD s0);  
    t.reg(syntPAD s1);  
    t.reg(syntPAD s2);  
    t.reg(syntPAD s3);  


    t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
    // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
    "{c" + seq => t.seq;
    0.26 * data.master_gain => t.gain;
    //t.sync(4*data.tick);// t.element_sync();// 
    t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
    // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
    t.set_adsrs(2*data.tick, 10::ms, 1, 6*data.tick);
    //t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => t.set_disconnect_mode;
    t.go();   t $ ST @=> ST @ last; 

    1::samp => now; // let seq() be sporked to compute length

    STREC strec;
    strec.connect(last $ ST, t.s.duration, name, 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ ); strec $ ST @=>  last;  

    STMIX stmix;
    stmix.send(last, mixer);

    t.s.duration + 2::ms => now;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////
fun void  SYNT1  (dur d, float g){ 
TONE t;
t.reg(SERUM0 s0); s0.config(22, 0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 }c }c 8/1__1/8 _3_5_ 1__3 _8__ 188/1" => t.seq;
g * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
//t.no_sync();//  t.full_sync(); //
4 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


STCUTTER stcutter;
" *2 111_ ____ 111_ __1_" => stcutter.t.seq;
4 * data.tick => stcutter.t.the_end.fixed_end_dur;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 


STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 60* 10 /* f_base */ , 110 * 10  /* f_var */, 1::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STMIX stmix;
stmix.send(last, mixer + 1);

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 {c 1538 3851 0083 B " => arp.t.seq;
4 * data.tick => arp.t.the_end.fixed_end_dur;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 


// MOD ////////////////////////////////

SinOsc mod => SinOsc s => OFFSET o => s0.inlet;
1::second / (13 * data.tick) => s.freq;

.2 => mod.freq;

1.2 => o.offset;
.7 => o.gain;

// MOD ////////////////////////////////

   
   
    d => now;
} 


///////////////////////////////////////////////////////////////////////////////////////////////
fun void  SYNT2  (dur d, float g){ 
TONE t;
t.reg(SERUM0 s0); s0.config(24, 0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 }c }c 8/1__1/8 _3_5_ 1__3 _8__ 188/1" => t.seq;
g * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
//t.no_sync();//  t.full_sync(); //
4 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


STCUTTER stcutter;
" *2 __1_ 111_ ____ 111_" => stcutter.t.seq;
4 * data.tick => stcutter.t.the_end.fixed_end_dur;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 1 /* period */, Std.rand2f(0.,1.) /* phase 0..1 */ );       autopan $ ST @=>  last; 



STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 160* 10 /* f_base */ , 110 * 10  /* f_var */, 1::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STMIX stmix;
stmix.send(last, mixer + 1);

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 {c 1538 3851 0083 B " => arp.t.seq;
4 * data.tick => arp.t.the_end.fixed_end_dur;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 


// MOD ////////////////////////////////

SinOsc mod => SinOsc s => OFFSET o => s0.inlet;
1::second / (13 * data.tick) => s.freq;

.2 => mod.freq;

1.2 => o.offset;
.7 => o.gain;

// MOD ////////////////////////////////

   
   
    d => now;
} 

///////////////////////////////////////////////////////////////////////////////////////////////
fun void  SYNT3  (dur d, float g){ 
TONE t;
t.reg(SERUM0 s0); s0.config(34, 2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
____ ___ *8 4812 0351 :8
____ ___G/h
____ __F/hh/F
____ ___ *8 4_12 _3_1 :8
" => t.seq;
g * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
//t.no_sync();//  t.full_sync(); //
2 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


ARP arp;
arp.t.dor();
//50::ms => arp.t.glide;
"*4 1538 481038  " => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 


STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 1400  /* f_var */, 1::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STMIX stmix;
stmix.send(last, mixer + 1);
   
   
    d => now;
} 


///////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////
fun void  SYNT4  (dur d, float g){ 
TONE t;
t.reg(SERUM0 s0); s0.config(36, 2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
*6 123 419 :6 ___ ____ 
___G/h ____
*6 12//3 4//19 :6 ___ ____ 
___h/G ____
" => t.seq;
g * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
//t.no_sync();//  t.full_sync(); //
2 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


ARP arp;
arp.t.dor();
//50::ms => arp.t.glide;
"*4 8 481153038  " => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 


STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 1400  /* f_var */, 1::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STMIX stmix;
stmix.send(last, mixer + 1);
   
   
    d => now;
} 

///////////////////////////////////////////////////////////////////////////////////////////////
fun void  PLOC  (dur d, float g){ 

  TONE t;
  t.reg(PLOC0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "*6
    8351 7241
    " => t.seq;
  g * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
//  1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  ARP arp;
  arp.t.dor();
  6 * data.tick => arp.t.the_end.fixed_end_dur;
  50::ms => arp.t.glide;
  "*4 1538 31841329  " => arp.t.seq;
  arp.t.go();   

  // CONNECT SYNT HERE
  3 => s0.inlet.op;
  arp.t.raw() => s0.inlet; 

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 5 / 1 /* period */,  Std.rand2f(0.,1.)/* phase 0..1 */ );       autopan $ ST @=>  last; 


  STFILTERMOD fmod;
  fmod.connect( last , "BPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 160 /* f_base */ , 2200  /* f_var */, 1::second / (17 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

  STMIX stmix;
  stmix.send(last, mixer + 1);


  d => now;
} 

///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
fun void  PLOCHIGH  (dur d, float g){ 

  TONE t;
  t.reg(PLOC0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "}c *6
    8351 7241
    " => t.seq;
  g * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
//  1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  ARP arp;
  arp.t.dor();
  6 * data.tick => arp.t.the_end.fixed_end_dur;
  50::ms => arp.t.glide;
"*4 8 318413095315329  " => arp.t.seq;
  arp.t.go();   

  // CONNECT SYNT HERE
  3 => s0.inlet.op;
  arp.t.raw() => s0.inlet; 

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 3 / 1 /* period */,  Std.rand2f(0.,1.)/* phase 0..1 */ );       autopan $ ST @=>  last; 


  STFILTERMOD fmod;
  fmod.connect( last , "BPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 160 /* f_base */ , 2200  /* f_var */, 1::second / (15 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

  STMIX stmix;
  stmix.send(last, mixer + 1);


  d => now;
} 

///////////////////////////////////////////////////////////////////////////////////////////////

class syntSQR extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

fun void  SYNTSQR  (dur d, float g){ 
  TONE t;
  t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c{c{c{c{c 
  8////1 ____
  f//1__ ____
  1////8 ____
  8////1 ____
  1//f__ ____
  " => t.seq;
  g * data.master_gain => t.gain;
//  t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  SYNC sy;
  sy.sync(4 * data.tick);
  //sy.sync(4 * data.tick , 0::ms /* offset */); 

  STFILTERMOD fmod;
  fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 5 /* Q */, 600 /* f_base */ , 2400  /* f_var */, 1::second / (4 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

  STHPF hpf;
  hpf.connect(last $ ST , 20 *10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 12 / 1 /* period */, Std.rand2f(0.,1.) /* phase 0..1 */ );       autopan $ ST @=>  last; 

  STMIX stmix;
  stmix.send(last, mixer + 1);


  d => now;
} 

///////////////////////////////////////////////////////////////////////////////////////////////
fun void  SYNTSQR2  (dur d, float g){ 
  TONE t;
  t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "{c{c{c{c
  8////1 ____
  f//1__ ____
  1////8 ____
  1//f__ ____
  " => t.seq;
  g * data.master_gain => t.gain;
//  t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  SYNC sy;
  sy.sync(4 * data.tick);
  //sy.sync(4 * data.tick , 0::ms /* offset */); 

  STFILTERMOD fmod;
  fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 5 /* Q */, 600 /* f_base */ , 2400  /* f_var */, 1::second / (4 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

  STHPF hpf;
  hpf.connect(last $ ST , 20 *10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 12 / 1 /* period */, Std.rand2f(0.,1.) /* phase 0..1 */ );       autopan $ ST @=>  last; 

  STMIX stmix;
  stmix.send(last, mixer + 1);


  d => now;
} 

///////////////////////////////////////////////////////////////////////////////////////////////

SinOsc sin0 =>  OFFSET ofs0 => blackhole;
1.3 => ofs0.offset;
0.6 => ofs0.gain;

0.1 => sin0.freq;
1.0 => sin0.gain;


fun void  LSDMOD  (float g) 
{
   SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"../_SAMPLES/lsd/lsd.wav" => s.wav["a"];
//"../_SAMPLES/lsd/once.wav" => s.wav["b"];
//"../_SAMPLES/lsd/reallychange.wav" => s.wav["c"];
//"../_SAMPLES/lsd/aware.wav" => s.wav["d"];
//"../_SAMPLES/lsd/happening.wav" => s.wav["e"];
//"../_SAMPLES/lsd/thelsd.wav" => s.wav["f"];
//"../_SAMPLES/lsd/full.wav" => s.wav["g"];
//aware.wav  full.wav  happening.wav    once.wav  reallychange.wav  thelsd.wav

"a___ ____" => s.seq;
g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //
s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 5 / 2 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

  STMIX stmix;
  stmix.send(last, mixer + 1);


  now + 8 * data.tick => time t;

    while(now < t) {
       ofs0.last () => s.wav_o["a"].wav0.rate;
       1::ms => now;
    }
     
 


   
} 



///////////////////////////////////////////////////////////////////////////////////////////////
fun void  LSD  (float g){ 
  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"../_SAMPLES/lsd/lsd.wav" => s.wav["a"];
"../_SAMPLES/lsd/once.wav" => s.wav["b"];
"../_SAMPLES/lsd/reallychange.wav" => s.wav["c"];
"../_SAMPLES/lsd/aware.wav" => s.wav["d"];
"../_SAMPLES/lsd/happening.wav" => s.wav["e"];
"../_SAMPLES/lsd/thelsd.wav" => s.wav["f"];
"../_SAMPLES/lsd/full.wav" => s.wav["g"];
//aware.wav  full.wav  happening.wav    once.wav  reallychange.wav  thelsd.wav

"
 c___ ____
 b___ ____
 d___ ____
 e___ e___
 e___ e___

" => s.seq;
g * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //
s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, mixer + 2);

 1::samp => now;
 s.s.duration => now;
} 


////////////////////////////////////////////////////////////////////////////////////////////

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


STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, cut /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

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
class syntOneP extends SYNT{
  inlet => Gain in;
  Gain out =>  outlet;   

  0 => int i;
  Gain opin[8];
  Gain opout[8];
  ADSR adsrop[8];
  TriOsc osc[8];

  // build and config operators
  //---------------------
  opin[i] => osc[i] => adsrop[i] => opout[i];
  1. => opin[i].gain;
  adsrop[i].set(1::ms, 20::ms, 1. , 2::ms);
  1 => adsrop[i].gain;
  i++;

  //---------------------
  opin[i] => osc[i] => adsrop[i] => opout[i];
  1./4. + 0.00 => opin[i].gain;
  adsrop[i].set(10::ms, 100::ms, 1. , 200::ms);
  100 * 7 => adsrop[i].gain;
  i++;

  //---------------------
  //      opin[i] =>;
  Step st => osc[i] => adsrop[i] => opout[i];
  2. => st.next;
  1./8. +0.0 => opin[i].gain;
  adsrop[i].set(100::ms, 186::ms, 1. , 1800::ms);
  15 * 100 => adsrop[i].gain;
  i++;

  //---------------------
  opin[i] => osc[i] => adsrop[i] => opout[i];
  1./2. +0.000 => opin[i].gain;
  adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
  30 => adsrop[i].gain;
  i++;

  // connect operators
  // main osc
  in => opin[0]; opout[0]=> out; 

  // modulators
  in => opin[1];
  opout[1] => opin[0];

  in => opin[2];
  opout[2] => opin[0];

  in => opin[3];
  //      opout[3] => opin[0];


  .5 => out.gain;

  fun void on()  
  {
    for (0 => int i; i < 8      ; i++)
    {
      adsrop[i].keyOn();
      // 0=> osc[i].phase;
    }

  } 

  fun void off() 
  {
    for (0 => int i; i < 8      ; i++) 
    {
      adsrop[i].keyOff();
    }


  } 

  fun void new_note(int idx)  
  { 

    if(idx == 0) {

      0.2 => osc[2].phase;        
      <<<"PHASE UPDATE">>>;
    }

  }
  0 => own_adsr;
}  


fun void  ONEP0  (string s, float g){ 


  TONE t;
  t.reg(syntOneP s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  //
  //t.lyd(); // t.ion(); // t.mix();// 
  t.dor();// t.aeo(); // t.phr();// t.loc();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  s => t.seq;
  1.7 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STLPF lpf;
  lpf.connect(last $ ST ,  6 * 100 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

  //==============================================================================================
  STECHO ech;
  ech.connect(last $ ST , data.tick * 8 / 8 , .3);  ech $ ST @=>  last; 

  STFILTERMOD fmod;
  fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 600 /* f_base */ , 8* 100  /* f_var */, 1::second / (12 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 



  STCOMPRESSOR stcomp;
  4. => float in_gain;
  stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   

  STAUTOPAN autopan;
  autopan.connect(last $ ST, .3 /* span 0..1 */, 3*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STMIX stmix;
stmix.send(last, mixer + 1);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration  => now;
} 


////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////

fun void PLOC (string seq, int n, float lpf_f,  float v) {

  TONE t;
  t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
  s0.config(n /* synt nb */ ); 
//  gldur => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  //t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
  t.dor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  seq => t.seq;
  v * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(2::ms, 50::ms, .00002, 400::ms);
t.set_adsrs_curves(0.6, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
  t.go();   t $ ST @=> ST @ last; 

  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
  stlpfx0.connect(last $ ST ,  stlpfx0_fact, lpf_f /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

  STREVAUX strevaux;
  strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;

}

////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

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


// spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 

////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////



SYNC sy;
sy.sync(1 * data.tick);

1. => data.master_gain;

155 => data.bpm;   (60.0/data.bpm)::second => data.tick;
50 => data.ref_note;
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
1*data.tick => w.sync_end_dur;


////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 
//.65 => stmix.gain;

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 6 /* freq */); 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 1400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  



STMIX stmix2;
stmix2.receive(mixer + 1); stmix2 $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 



STMIX stmix3;
stmix3.receive(mixer + 2); stmix3 $ ST @=>  last; 

STREVAUX strevaux2;
strevaux2.connect(last $ ST, .1 /* mix */); strevaux2 $ ST @=>  last; 

STECHO ech2;
ech2.connect(last $ ST , data.tick * 3 / 4 , .3);  ech2 $ ST @=>  last; 

/////////////////////////////////////////////////////////////////////////////////////////

fun void  LOOP_LAB  (){ 
  while(1) {
    //  if (maybe) spork ~   SYNT1 (8 * data.tick, .7); 
    //  if (maybe) spork ~   SYNT3 (8 * data.tick, .7); 
    //  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ _kk_  "); 
    //  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
    //  8 * data.tick =>  w.wait;   

    //  if (maybe)   spork ~   SYNT2 (8 * data.tick, .7); 
    //  if (maybe)   spork ~   SYNT4 (8 * data.tick, .7); 
    //  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ _kk_  "); 
    //  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
    //  8 * data.tick =>  w.wait;   

//     spork ~ PLOC (3 * data.tick, .7); 

//     spork ~ PLOCHIGH (3 * data.tick, .7); 
//     spork ~ SYNTSQR(8 * data.tick, 1.7); 
////     spork ~ SYNTSQR2 (8 * data.tick, 1.7); 
//      spork ~ LSDMOD (2.); 
//      spork ~ LSD (1.); 
//      32 * data.tick =>  w.wait;   


  spork ~   SYNT4 (8 * data.tick, .7);
   spork ~   MODU6 (292, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 13 *100, .42); 
   spork ~   MODU6 (324, " ____ __ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
   spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k_  "); 
  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2hh_h uh_:2    "); 
  8 * data.tick =>  w.wait;   

  spork ~   SYNT3 (8 * data.tick, .7);
   spork ~   ONEP0 (" *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
   spork ~   MODU6 (307, "__*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 25 *100, .24); 
   spork ~   ONEP0 ("____ _*4  " + RAND.seq("8//1_,f/8_,F/1_,5//F_,f/1_", 3), 4.1); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ kk__  "); 
  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2hh_h uh_:2    "); 
  8 * data.tick =>  w.wait;   

  spork ~   SYNT2 (8 * data.tick, .7);
  spork ~   MODU6 (324, " ____ __ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
  spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k_  "); 
  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2hh_h uh_:2    "); 
  8 * data.tick =>  w.wait;   

   spork ~   ONEP0 ("*4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
   spork ~   MODU6 (324, " ____ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
   spork ~   ONEP0 ("____ __*4  " + RAND.seq("8//1_,f/8_,F/1_,5//F_,f/1_", 2), 4.1); 

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ kk__  "); 
  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2hh_h uh_:2    "); 
  8 * data.tick =>  w.wait;   


  }
   
} 
//LOOP_LAB();

fun void  BEAT (){ 
  WAIT w;
  1*data.tick => w.sync_end_dur;

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ kk__  "); 
  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2hh_h uh_:2    "); 
  8 * data.tick =>  w.wait;   

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_k_  "); 
  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   


  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ kk_k  "); 
  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2hh_h uh_:2    "); 
  8 * data.tick =>  w.wait;   


  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_kk  "); 
  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   

} 


///////////////////// PLAYBACK/REC /////////////////////////

0 => int compute_mode; // play song with real computing
0 => int rec_mode; // While playing song in compute mode, rec it

"l5d_main.wav" => string name_main;
"l5d_aux.wav" => string name_aux;
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



  spork ~  BEAT (); 

  8 * data.tick =>  w.wait;   
  spork ~   SYNT1 (8 * data.tick, .7); 
  8 * data.tick =>  w.wait;   
  spork ~   SYNT3 (8 * data.tick, .7);
  8 * data.tick =>  w.wait;   
  spork ~ PLOC (3 * data.tick, .7); 
  8 * data.tick =>  w.wait;   

  spork ~  BEAT (); 
  
  spork ~ SYNTSQR(8 * data.tick, 1.7);
  8 * data.tick =>  w.wait;   
  spork ~   SYNT4 (8 * data.tick, .7); 
  8 * data.tick =>  w.wait;   
  spork ~   SYNT2 (8 * data.tick, .7);
  8 * data.tick =>  w.wait;   
  spork ~ PLOCHIGH (3 * data.tick, .7); 
  8 * data.tick =>  w.wait;   

  spork ~  BEAT (); 
  spork ~ LSDMOD (0.8);
  8 * data.tick =>  w.wait;   
  spork ~   SYNT3 (8 * data.tick, .7); 
  8 * data.tick =>  w.wait;   
  spork ~ PLOCHIGH (3 * data.tick, .7); 
  spork ~ LSDMOD (.8);
  8 * data.tick =>  w.wait;   
  spork ~   SYNT1 (8 * data.tick, .7);
  8 * data.tick =>  w.wait;   

  spork ~  KICK3 ("*4 k___ "); 
  spork ~   SYNT3 (8 * data.tick, .7);
  spork ~ SYNTSQR2(8 * data.tick, 1.7);
  spork ~   PAD (1, "}c :8 1|3|5|6_3|6|8|c_", 0.6 ); 
  spork ~   PAD (2, "}c :8 _B|0|2|4__ ___0|2|5|7" , 0.6); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 ____ ____ ____ ____ k___ k_k_ kkkk *2kkkk kkkk"); 
  8 * data.tick =>  w.wait;  

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ _k_k  "); 
  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2hh_h uh_:2    "); 
  8 * data.tick =>  w.wait;   


  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ __kk  "); 
  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   

  spork ~ LSD (1.); 
  spork ~  BEAT (); 
  32 * data.tick =>  w.wait;   
  spork ~  BEAT (); 
  8 * data.tick =>  w.wait;   
  spork ~   SYNT3 (8 * data.tick, .7); 
  8 * data.tick =>  w.wait;   
  spork ~ PLOCHIGH (3 * data.tick, .7); 
  spork ~ LSDMOD (.8);
  8 * data.tick =>  w.wait;   
  spork ~   SYNT1 (8 * data.tick, .7);
  8 * data.tick =>  w.wait;   

  spork ~ LSDMOD (0.8);
  spork ~  KICK3 ("*4 k___ "); 
  spork ~   SYNT2 (8 * data.tick, .7);
  spork ~ SYNTSQR2(8 * data.tick, 1.7);
  spork ~   PAD (1, "}c :8 1|3|5|6_3|6|8|c_", 0.6 ); 
  spork ~   PAD (2, "}c :8 _B|0|2|4__ ___0|2|5|7" , 0.6); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 ____ ____ ____ ____ k___ k_k_ kkkk *2kkkk kkkk"); 
  8 * data.tick =>  w.wait;  


 ///////////////////////////////////////////////////////////////////////////////////////////////////////////

  spork ~  BEAT (); 

  8 * data.tick =>  w.wait;   
  spork ~   SYNT1 (8 * data.tick, .7); 
  8 * data.tick =>  w.wait;   
  spork ~   SYNT3 (8 * data.tick, .7);
  8 * data.tick =>  w.wait;   
  spork ~ PLOC (3 * data.tick, .7); 
  8 * data.tick =>  w.wait;   

  spork ~  BEAT (); 
  
  spork ~ SYNTSQR(8 * data.tick, 1.7);
  8 * data.tick =>  w.wait;   
  spork ~   SYNT4 (8 * data.tick, .7); 
  8 * data.tick =>  w.wait;   
  spork ~   SYNT2 (8 * data.tick, .7);
  8 * data.tick =>  w.wait;   
  spork ~ PLOCHIGH (3 * data.tick, .7); 
  8 * data.tick =>  w.wait;   

  spork ~  BEAT (); 
  spork ~ LSDMOD (0.8);
  8 * data.tick =>  w.wait;   
  spork ~   SYNT3 (8 * data.tick, .7); 
  8 * data.tick =>  w.wait;   
  spork ~ PLOCHIGH (3 * data.tick, .7); 
  spork ~ LSDMOD (.8);
  8 * data.tick =>  w.wait;   
  spork ~   SYNT1 (8 * data.tick, .7);
  8 * data.tick =>  w.wait;   

  spork ~  KICK3 ("*4 k___ "); 
  spork ~   SYNT3 (8 * data.tick, .7);
  spork ~ SYNTSQR2(8 * data.tick, 1.7);
  spork ~   PAD (1, "}c :8 1|3|5|6_3|6|8|c_", 0.6 ); 
  spork ~   PAD (2, "}c :8 _B|0|2|4__ ___0|2|5|7" , 0.6); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 ____ ____ ____ ____ k___ k_k_ kkkk *2kkkk kkkk"); 
  8 * data.tick =>  w.wait;  

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ _k_k  "); 
  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2hh_h uh_:2    "); 
  8 * data.tick =>  w.wait;   


  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ __kk  "); 
  spork ~  BASS0 ("*4 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!0!1 !1!1!1!1 !1!1!3!1 !1!1!1!1 !1!1!1!1"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   

  spork ~   PAD (1, "}c :8 1|3|5|6_3|6|8|c_", 0.6 ); 
  spork ~   PAD (2, "}c :8 _B|0|2|4__ ___0|2|5|7" , 0.6); 
  spork ~ LSDMOD (0.8);
  spork ~  BEAT (); 
  32 * data.tick =>  w.wait;   
  spork ~  BEAT (); 
  8 * data.tick =>  w.wait;   
  spork ~   SYNT3 (8 * data.tick, .7); 
  8 * data.tick =>  w.wait;   
  spork ~ PLOCHIGH (3 * data.tick, .7); 
  spork ~ LSDMOD (.8);
  8 * data.tick =>  w.wait;   
  spork ~   SYNT1 (8 * data.tick, .7);
  8 * data.tick =>  w.wait;   

  spork ~ LSDMOD (0.8);
  spork ~  KICK3 ("*4 k___ "); 
  spork ~   SYNT2 (8 * data.tick, .7);
  spork ~ SYNTSQR2(8 * data.tick, 1.7);
  spork ~   PAD (1, "}c :8 1|3|5|6_3|6|8|c_", 0.6 ); 
  spork ~   PAD (2, "}c :8 _B|0|2|4__ ___0|2|5|7" , 0.6); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 ____ ____ ____ ____ k___ k_k_ kkkk *2kkkk kkkk"); 
  8 * data.tick =>  w.wait;  

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
 spork ~  SLIDENOISE(252 /* fstart */, 3000 /* fstop */, 15* data.tick /* dur */, .8 /* width */, .11 /* gain */); 

  spork ~  KICK3 ("*4 k___ ____ k___ ____ k___ k___ k___ k___ "); 

  spork ~   SYNT2 (8 * data.tick, .7);
  spork ~   MODU6 (324, " ____ __ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
  spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  8 * data.tick =>  w.wait;   

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k_k_ kkkk *2kkkk kkkk "); 
  spork ~   ONEP0 ("*4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  spork ~   MODU6 (324, " ____ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
  spork ~   ONEP0 ("____ __*4  " + RAND.seq("8//1_,f/8_,F/1_,5//F_,f/1_", 2), 4.1); 

  8 * data.tick =>  w.wait;   

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    main_extra_time =>  w.wait;  // Wait for Echoes REV to complete
    strec.rec_stop( 0::ms, 1);
    strecaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////

  
///////////////////////// END LOOP ///////////////////////////////////::
0 => data.next;

while (!data.next) {

  <<<"**********">>>;
  <<<" END LOOP ">>>;
  <<<"**********">>>;

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


  spork ~  BEAT (); 
  spork ~   SYNT4 (8 * data.tick, .7);
  spork ~   MODU6 (292, "*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 13 *100, .42); 
  spork ~   MODU6 (324, " ____ __ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
  spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  8 * data.tick =>  w.wait;   

  spork ~   SYNT3 (8 * data.tick, .7);
  spork ~   ONEP0 (" *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  spork ~   MODU6 (307, "__*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 25 *100, .24); 
  spork ~   ONEP0 ("____ _*4  " + RAND.seq("8//1_,f/8_,F/1_,5//F_,f/1_", 3), 4.1); 
  8 * data.tick =>  w.wait;   

  spork ~   SYNT2 (8 * data.tick, .7);
  spork ~   MODU6 (324, " ____ __ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
  spork ~   ONEP0 ("__ *4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  8 * data.tick =>  w.wait;   

  spork ~ SYNTSQR2(8 * data.tick, 1.7);
  spork ~   ONEP0 ("*4*2 }c " + RAND.seq("1_3_,5___,8___,__B_,5___, __8_,____,B_B_,1_3_, 5___ ,8_0_, __A_", 8), 4.1); 
  spork ~   MODU6 (324, " ____ *8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 4), "*4 L/MM/IL/I", "}c  f", 20 *100, .35); 
  spork ~   ONEP0 ("____ __*4  " + RAND.seq("8//1_,f/8_,F/1_,5//F_,f/1_", 2), 4.1); 

  8 * data.tick =>  w.wait;   

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

// END
  spork ~   ONEP0 ("*4  " + RAND.seq("8//1_,f/8_,F/1_,5//F_,f/1_", 4), 4.1); 
  spork ~  KICK3 ("*4 k___  "); 
  16 * data.tick =>  w.wait;   
  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    // Note extra time to add above
    strecend.rec_stop( 0::ms, 1);
    strecendaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


}

 

