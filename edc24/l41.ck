21 => int mixer;

///////////////////////////////////////////////////////////////////////////////////////////////

fun void KICK3(string seq) {

TONE t;
t.reg(KIK kik);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
kik.config(0.1 /* init Sin Phase */, 17 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (250.0, 2::ms);
kik.addFreqPoint (90.0, 50::ms);
kik.addFreqPoint (31.0, 4 * 10::ms);

kik.addGainPoint (0.6, 13::ms);
kik.addGainPoint (0.4, 25::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 4 * 10::ms);
kik.addGainPoint (0.0, 15::ms); 


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
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 4::ms /* Release */ );      duckm $ ST @=>  last; 




  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


///////////////////////////////////////////////////////////////////////////////////////////////


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

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 0.38 =>p.phase; } 1 => own_adsr;
} 

class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .8 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { 
          .50 => s.phase;
          } 0 => own_adsr;
}

fun void BASS0 (string seq) {
TONE t;
//t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM00X s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(2330 /* synt nb */ ); // 2209: sawXbit, 2310: bw_saw, 2360: saw_bright 2370 : saw_gap 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c" + seq => t.seq;
0.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(0::ms, 10::ms, 1, 4::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

//STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//sthpfx0.connect(last $ ST ,  sthpfx0_fact, 1* 10.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  


STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(11 * 10 /* Base */, 69 * 10 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.0 /* Relative Attack */, 53*  .01/* Relative Decay */, 0.17 /* Sustain */, .19 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0,196 * 0.001, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 3 /* order */, 1 /* channels */ , 1::samp /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 


STADSR stadsr;
stadsr.set(4::ms /* Attack */, 0::ms /* Decay */, 1. /* Sustain */, -0.3 /* Sustain dur of Relative release pos (float) */,  20::ms /* release */);
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


////////////////////////////////////////////////////////////////////////////////////////
fun void  SYNT1 (string seq, string Arp, int nb, dur glide, float g, dur d){ 
   
   TONE t;
   t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
   s0.config(nb /* synt nb */ ); 

   glide => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
   t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

    ARP arp;
    arp.t.dor();
    50::ms => arp.t.glide;
    Arp => arp.t.seq;
    arp.t.go();   

    // CONNECT SYNT HERE
    3 => s0.inlet.op;
    arp.t.raw() => s0.inlet; 


STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 4 * 100 /* freq base */, 25 * 100 /* freq var */, data.tick * 13 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 16* 100.0 /* freq */ , 1.1 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  


   d => now;

} 


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
fun void  SYNT2 (string seq, string Arp, int nb, dur glide, float g, dur d){ 
   
   TONE t;
   t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
   s0.config(nb /* synt nb */ ); 

   glide => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
   t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
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

    ARP arp;
    arp.t.dor();
    50::ms => arp.t.glide;
    Arp => arp.t.seq;
    arp.t.go();   

    // CONNECT SYNT HERE
    3 => s0.inlet.op;
    arp.t.raw() => s0.inlet; 


STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 1.0 /* Q */, 4 * 100 /* freq base */, 25 * 100 /* freq var */, data.tick * 13 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 26* 100.0 /* freq */ , 1.3 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  


STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, .3 /* mix */); strevaux $ ST @=>  last;  

   d => now;

} 
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


////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAV  (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer + 1);
  
   g => s.gain;

   file => s.read;

   s.length() => now;

} 

//   spork ~   SINGLEWAV("../_SAMPLES/", .4); 

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
stmix.send(last, mixer  );

1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;
}


////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////

SYNC sy;
sy.sync(1 * data.tick);

1. => data.master_gain;

150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
53 => data.ref_note;

WAIT w;
1*data.tick => w.sync_end_dur;

//2 * data.tick =>  w.wait; 

////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 6 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 
///////////////////// PLAYBACK/REC /////////////////////////

0 => int compute_mode; // play song with real computing
0 => int rec_mode; // While playing song in compute mode, rec it

"Spock_main.wav" => string name_main;
"Spock_aux.wav" => string name_aux;
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
 
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
//}if (0) {
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1_ _!1_ _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k_k_ k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1_!1 _!1_ _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_*2 kkkk k___  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_"); 
  8 * data.tick =>  w.wait;   

 spork ~  SLIDENOISE(50 /* fstart */, 3000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .17 /* gain */);  

  spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_   "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_ __!88_"); 
  8 * data.tick =>  w.wait;   



////////////////////////////////////////////////////////////////////////////////////////////

//           SYNT TIME

///////////////////////////////////////////////////////////////////////////////////////////:
  spork ~ SYNT1 ("*4  84B21" /* seq*/, "*2 11118 111B" /*arp*/, 8 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 64 * data.tick /* dur */ );

  //" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
  //"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
   
  spork ~ SYNT2 ("*8  5_3_1_" /* seq*/, "*3:211F" /*arp*/, 10 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 64 * data.tick /* dur */ );


  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
//}if (0) {
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1_ _!1_ _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k_k_ k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1_!1 _!1_ _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_*2 kkkk k___  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_   "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_ __!88_"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   


  //////////////////////////////////////////////////////////////////////////////////////:

  //                           SPOCK

  /////////////////////////////////////////////////////////////////////////////////////////:

  spork ~   SINGLEWAV("../_SAMPLES/Spock/MedicOnSpock.wav", .3); 

 

  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
//}if (0) {
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1_ _!1_ _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k_k_ k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1_!1 _!1_ _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_*2 kkkk k___  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_"); 
  8 * data.tick =>  w.wait;   

 spork ~  SLIDENOISE(50 /* fstart */, 3000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .17 /* gain */);  

  spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_   "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_ __!88_"); 
  8 * data.tick =>  w.wait;   

/// *****************************************************************

  spork ~ SYNT1 ("*4  831" /* seq*/, "*2 11118 111B" /*arp*/, 9 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 64 * data.tick /* dur */ );



  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
//}if (0) {
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1_ _!1_ _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k_k_ k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1_!1 _!1_ _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_*2 kkkk k___  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   

 spork ~  SLIDENOISE(50 /* fstart */, 3000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .17 /* gain */);  

  spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_   "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_ __!88_"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   


/// *****************************************************************



  spork ~ SYNT1 ("*4 }c__8__8 _8__8 __8__8__8__*2 8_8_" /* seq*/, "*2 1111111118" /*arp*/, 1 /* SERUM00 nb */ ,0::ms /* glide */, .2 /* g */ , 64 * data.tick /* dur */ );



  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
//}if (0) {
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1_ _!1_ _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k_k_ k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1_!1 _!1_ _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_*2 kkkk k___  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_"); 
  8 * data.tick =>  w.wait;   
 spork ~  SLIDENOISE(50 /* fstart */, 3000 /* fstop */, 16* data.tick /* dur */, .5 /* width */, .17 /* gain */);  

   spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___   "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1_"); 
  8 * data.tick =>  w.wait;   


  ///////////////// $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


  spork ~ SYNT1 ("*4  831" /* seq*/, "*2 11118 111B" /*arp*/, 9 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 64 * data.tick /* dur */ );

  spork ~ SYNT1 ("*4 }c__8__8 _8__8 __8__8__8__*2 8_8_" /* seq*/, "*2 1111111118" /*arp*/, 1 /* SERUM00 nb */ ,0::ms /* glide */, .2 /* g */ , 64 * data.tick /* dur */ );



  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
//}if (0) {
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1_ _!1_ _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k_k_ k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1_!1 _!1_ _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_*2 kkkk k___  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_   "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_ __!88_"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   

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



  spork ~ SYNT1 ("*4 }c__8__8 _8__8 __8__8__8__*2 8_8_" /* seq*/, "*2 1111111118" /*arp*/, 1 /* SERUM00 nb */ ,0::ms /* glide */, .2 /* g */ , 64 * data.tick /* dur */ );

   spork ~   MODU6 (288, "____*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .27); 
  spork ~ SYNT1 ("*4  831" /* seq*/, "*2 11118 111B" /*arp*/, 9 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 4 * data.tick /* dur */ );




  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
   spork ~   MODU6 (288, "____*8 }c}c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .27); 
  spork ~ SYNT1 ("*4  831" /* seq*/, "*2 11118 111B" /*arp*/, 9 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 4 * data.tick /* dur */ );


  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k__k k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1_ _!1_ _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
   spork ~   MODU6 (288, "____*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .27); 
  spork ~ SYNT1 ("*4  831" /* seq*/, "*2 11118 111B" /*arp*/, 9 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 4 * data.tick /* dur */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
   spork ~   MODU6 (288, "____*8 }c}c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .27); 
  spork ~ SYNT1 ("*4  831" /* seq*/, "*2 11118 111B" /*arp*/, 9 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 4 * data.tick /* dur */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k_k_ k_kk__  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1_!1 _!1_ _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
   spork ~   MODU6 (288, "____*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .27); 
  spork ~ SYNT1 ("*4  831" /* seq*/, "*2 11118 111B" /*arp*/, 9 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 4 * data.tick /* dur */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
   spork ~   MODU6 (288, "____*8 }c}c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .27); 
  spork ~ SYNT1 ("*4  831" /* seq*/, "*2 11118 111B" /*arp*/, 9 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 4 * data.tick /* dur */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_*2 kkkk k___  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
   spork ~   MODU6 (288, "____*8 }c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .27); 
  spork ~ SYNT1 ("*4  831" /* seq*/, "*2 11118 111B" /*arp*/, 9 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 4 * data.tick /* dur */ );
  spork ~  KICK3 ("*4 ____ k___ k___ k___ k___ k___ k___ k_____  "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!5!3 _"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
  8 * data.tick =>  w.wait;   
   spork ~   MODU6 (288, "____*8 }c}c" + RAND.seq("1_1_,__1_,8/1___,f/F_8_,1_5_,!8!5!1_", 6), "*4 L/MM/IL/I", "}c  f", 10 *100, .27); 
 
  spork ~ SYNT1 ("*4  831" /* seq*/, "*2 11118 111B" /*arp*/, 9 /* SERUM00 nb */ , 10::ms /* glide */, .2 /* g */ , 4 * data.tick /* dur */ );
  spork ~  KICK3 ("*4 k___ k___ k___ k___ k___ k___ kk_k k_   "); 
  spork ~  BASS0 ("*4    _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 _!1!1!1 __!1_ __!88_"); 
  spork ~  TRANCEHH (" *2 _huh _huh _huh *2_hhh:2uh    "); 
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
  spork ~  KICK3 ("*4 k___   "); 
 spork ~  SLIDENOISE(3000 /* fstart */,  50/* fstop */, 4* data.tick /* dur */, .5 /* width */, .17 /* gain */);  
  8 * data.tick =>  w.wait;   

  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    // Note extra time to add above
    strecend.rec_stop( 0::ms, 1);
    strecendaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


}

 

