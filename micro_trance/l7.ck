10 => int mixer;
/////////////////////////////////////////////////////////////////////////////////////////

fun void TRANCE(string seq) {

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

STOVERDRIVE stod;
stod.connect(last $ ST, 7.8 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 
.33 => stod.gain;

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

  STMIX stmix;
  stmix.send(last, mixer);

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

//spork ~ ACOUSTICTOM("*4 AA_B B_CC _DD_ SKKS ");




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
0.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
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

fun void GLITCH (string seq, string seq_cutter, string seq_arp,  int instru ) {
  
  TONE t;
  t.reg(SERUM0 s0); s0.config(instru, 0);  //data.tick * 8 => t.max; 
  60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  seq => t.seq;
  .3 * data.master_gain => t.gain;
  //t.sync(4*data.tick);// t.element_sync();// 
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 
  
  
  STCUTTER stcutter;
  stcutter.t.no_sync();
  seq_cutter => stcutter.t.seq;
  stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 
  
  
  ARP arp;
  arp.t.dor();
  50::ms => arp.t.glide; 
  arp.t.no_sync();
  seq_arp => arp.t.seq;
  arp.t.go();   
  
  // CONNECT SYNT HERE
  3 => s0.inlet.op;
  arp.t.raw() => s0.inlet; 
  
  
  // MOD ////////////////////////////////
  
   SinOsc mod => SinOsc s => OFFSET o => s0.inlet;
   1::second / (13 * data.tick) => s.freq;
 
//   SYNC sy;
//   sy.sync(1 * data.tick);
   //sy.sync(4 * data.tick , 0::ms /* offset */); 
   0 => s.phase;
   
   .2 => mod.freq;
   
   1.2 => o.offset;
   .7 => o.gain;
   
  // MOD ////////////////////////////////
  
  STMIX stmix;
  stmix.send(last, mixer + 1);

  1::samp => now; // let seq() be sporked to compute duration
  t.s.duration => now;
}

//spork ~ GLITCH("*8  8_3_5_1_______" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 {c 1538 3851 0083 B " /* seq_arp */, 23 /* instru */);

///////////////////////////////////////////////////////////////////////
fun void TRIBAL(string seq, int nb, int tomix, float g) {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  
  if ( nb == 0  ){
    SET_WAV.TRIBAL0(s);
  }
  else if (  nb == 1  ){
    SET_WAV.TRIBAL1(s);
  }
  else {
    SET_WAV.TRIBAL(s);
  }
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  seq => s.seq;
  g * 0.8 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.no_sync();// s.element_sync(); //s.no_sync()
; //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + 1);
  }

  1::samp => now; // let seq() be sporked to compute length
  s.s.duration => now;
}

// spork ~ TRIBAL("*4 __a_", 0 /* bank */, 0 /* tomix */, .5 /* gain */);


////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////

SYNC sy;
sy.sync(1 * data.tick);

1. => data.master_gain;

147 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

WAIT w;
1*data.tick => w.sync_end_dur;

// OUTPUT
STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 14 * 10. /* room size */, 1::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 


STMIX stmix2;
stmix2.receive(mixer+1); stmix2 $ ST @=> last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .4 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

///////////////////// PLAYBACK/REC /////////////////////////

0 => int compute_mode; // play song with real computing
0 => int rec_mode; // While playing song in compute mode, rec it

"Marquise_main.wav" => string name_main;
"Marquise_aux.wav" => string name_aux;
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

    
  spork ~   SINGLEWAV("../_SAMPLES/IlesMarquises/NukuHivaDanseDuCochon/IntroHomme.wav", 0.7); 
  65 * data.tick =>  w.wait; 
  spork ~   SINGLEWAVRATE("../_SAMPLES/IlesMarquises/conque.wav", 1.0, 0.6); 
  6 * data.tick =>  w.wait;
  spork ~ ACOUSTICTOM("*4 __U_  AABB CCDD D_UU  ");
  4 * data.tick =>  w.wait;

//////////////////////////////////////////////////////

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _1_1_1_1 _1_1_1_1 "); 
  spork ~  CHANT (" ab_c_ba_ AB_C_BA_");
  spork ~  CHANT (" AB_C_BA_ ab_c_ba_");

  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk "); 
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _1_1_1_1  "); 
  spork ~  CHANT (" ab_c_ba_ ");
  spork ~  CHANT (" AB_C_BA_ ");


  8 * data.tick =>  w.wait; 
  spork ~   SINGLEWAVRATE("../_SAMPLES/IlesMarquises/conque.wav", 1.0, 0.6); 
  4 * data.tick =>  w.wait;
  spork ~ ACOUSTICTOM("*4 __UM|D _M|DU_  ABCD M|D_UU  ");
  4 * data.tick =>  w.wait;
 

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ BASS ("*4  __11__11__1!1__11  __11__11__1!1_1_1  __11__11__1!1__11  __11__11__1!1_3_1 "); 
  spork ~ GLITCH("*8 }c  8_3_5_1_ ____ _____ f////F_" /* seq */,  "*2 11__ 1_1_ 111_ 1__1 1111 1_1_" /* seq_cutter */,  "*4 {c 1538 3851 0083 B " /* seq_arp */, 25 /* instru */);
  spork ~ GLITCH(" }c}c -3  ____ ____ *4 M////ff////M" /* seq */,  "*8 1" /* seq_cutter */,  "*8  1f" /* seq_arp */, 34 /* instru */);

  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk kk__"); 
  spork ~ BASS ("*4  __11__11__1!1__11  __11__11__1!1_1_1  __11__11__1!1__11  __11__11__*2 8_5_3_1_ 1111 "); 
   spork ~ GLITCH("*8 }c 89abcdefghijkl 89abcde " /* seq */,  "*2 11" /* seq_cutter */,  "*4 {c 1538 3851 0083 B " /* seq_arp */, 25 /* instru */);
  spork ~ GLITCH(" }c}c +0  ____ ____ *4 M////ff////M" /* seq */,  "*8 1" /* seq_cutter */,  "*4  18" /* seq_arp */, 35 /* instru */);

  12 * data.tick =>  w.wait; 
  spork ~ TRIBAL("*4 fghhgf ", 1 /* bank */, 1 /* tomix */, 1.1 /* gain */);
  4 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRIBAL("*4 __h_ s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_  __h_ s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ ", 2 /* bank */, 0 /* tomix */, .4 /* gain */);
  spork ~ TRIBAL("*4 A___ __x_ ____ ____  __-4z_ ____ ____ __HH", 0 /* bank */, 1 /* tomix */, 0.8 /* gain */);
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _1_1_1_1 _1_1_1_1 "); 
  spork ~  CHANT (" ab_c_ba_ AB_C_BA_");
  spork ~  CHANT (" AB_C_BA_ ab_c_ba_");

  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk "); 
  spork ~ TRIBAL("*4 __h_ s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_  __h_ s_h_ __h_ s_h_  ", 2 /* bank */, 0 /* tomix */, .4 /* gain */);
  spork ~ TRIBAL("____ ____ ____*4 _aaa _a_a _bb_ _b_b ", 2 /* bank */, 1 /* tomix */, .4 /* gain */);

  spork ~ TRIBAL("*4 A___ __x_ ____ ____  __-4z_ ____ ____ __HH", 0 /* bank */, 1 /* tomix */, 1.0 /* gain */);
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _1_1_1_1  "); 
  spork ~  CHANT (" ab_c_ba_ ");
  spork ~  CHANT (" AB_C_BA_ ");

  8 * data.tick =>  w.wait; 
  spork ~   SINGLEWAVRATE("../_SAMPLES/IlesMarquises/conque.wav", 1.0, 0.6); 
  4 * data.tick =>  w.wait; 
  spork ~ ACOUSTICTOM("*4 __UM|D M|DUM|DM|D UBCD M|DU_U  ");
  4 * data.tick =>  w.wait; 


  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRIBAL("*4 __h_ s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_  __h_ s_h_ __h_ s_h_  ", 2 /* bank */, 0 /* tomix */, .4 /* gain */);
  spork ~ BASS ("*4  __11__11__1!1__11  __11__11__1!1_1_1  __11__11__1!1__11  __11__11__1!1_3_1 "); 
  spork ~ GLITCH("*8 }c 89abcdefghijkl 89abcde ____ ____ *2 1_1_1_1_1_1_1_1_" /* seq */,  "*2 11" /* seq_cutter */,  "*4 {c 1" /* seq_arp */, 25 /* instru */);
  spork ~ GLITCH(" }c}c +0  ____ ____ *8 1_1_1_1_1_1_1_1_1_1_1_1_" /* seq */,  "*8 1" /* seq_cutter */,  "*4  1" /* seq_arp */, 10 /* instru */);

  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRIBAL("*4 __h_ s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_  __h_ s_h_ __h_ s_h_  ", 2 /* bank */, 0 /* tomix */, .4 /* gain */);
  spork ~ BASS ("*4  __11__11__1!1__11  __11__11__1!1_1_1  __11__11__1!1__11  __11__11__*2 8_5_3_1_ 1111 "); 
  spork ~ GLITCH(" }c +3 M////1 " /* seq */,  "*8 11" /* seq_cutter */,  "*4  1" /* seq_arp */, 24 /* instru */);
  spork ~ GLITCH(" }c -3  ____ ____ *4 1_1_1_1_1_1_1_1_1_1_1_1_" /* seq */,  "*8 1" /* seq_cutter */,  "*4  f18" /* seq_arp */, 26 /* instru */);


  12 * data.tick =>  w.wait; 
  spork ~ TRIBAL("*4 ZZZ", 1 /* bank */, 1 /* tomix */, 0.8 /* gain */);
  4 * data.tick =>  w.wait; 
  //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    main_extra_time =>  w.wait;  // Wait for Echoes REV to complete
    strec.rec_stop( 0::ms, 1);
    strecaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


0 => data.next;
while (!data.next) {
  
  <<<"********">>>;
  <<<"END LOOP">>>;
  <<<"********">>>;

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


  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRIBAL("*4 __h_ s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_  __h_ s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ ", 2 /* bank */, 0 /* tomix */, .4 /* gain */);
  spork ~ TRIBAL("*4 _aaa _a_a _bb_ _b_b _aaa _a_a _bb_ _b_b_aaa _a_a _bb_ _b_b_aaa _a_a _bb_ _b_b", 2 /* bank */, 0 /* tomix */, .4 /* gain */);
  spork ~ TRIBAL("*4 A___ __x_ ____ ____  __-4z_ ____ ____ __HH", 0 /* bank */, 1 /* tomix */, 0.8 /* gain */);
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _1_1_1_1 _1_1_1_1 "); 
  spork ~  CHANT (" ab_c_ba_ AB_C_BA_");
  spork ~  CHANT (" AB_C_BA_ ab_c_ba_");

  16 * data.tick =>  w.wait; 




  spork ~ TRANCE ("kkkk kkkk kkkk "); 
  spork ~ TRIBAL("*4 __h_ s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_  __h_ s_h_ __h_ s_h_  ", 2 /* bank */, 0 /* tomix */, .4 /* gain */);
  spork ~ TRIBAL("*4 _aaa _a_a _bb_ _b_b _aaa _a_a _bb_ _b_b_aaa _a_a _bb_ _b_b", 2 /* bank */, 0 /* tomix */, .4 /* gain */);
  spork ~ TRIBAL("____ ____ ____*4 _aaa _a_a _bb_ _b_b ", 2 /* bank */, 1 /* tomix */, .4 /* gain */);

  spork ~ TRIBAL("*4 A___ __x_ ____ ____  __-4z_ ____ ____ __HH", 0 /* bank */, 1 /* tomix */, 1.0 /* gain */);
  spork ~ BASS ("*2 _1_1_1_1 _1_1_1_1  _1_1_1_1  "); 
  spork ~  CHANT (" ab_c_ba_ ");
  spork ~  CHANT (" AB_C_BA_ ");

  8 * data.tick =>  w.wait; 
  spork ~   SINGLEWAVRATE("../_SAMPLES/IlesMarquises/conque.wav", 1.0, 0.6); 
  4 * data.tick =>  w.wait;
  spork ~ ACOUSTICTOM("*4 __U_  AABB CCDD D_UU  ");
  4 * data.tick =>  w.wait;

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRIBAL("*4 __h_ s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_  __h_ s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ ", 2 /* bank */, 0 /* tomix */, .4 /* gain */);
  spork ~ TRIBAL("*4 _aaa _a_a _bb_ _b_b _aaa _a_a _bb_ _b_b_aaa _a_a _bb_ _b_b_aaa _a_a _bb_ _b_b", 2 /* bank */, 0 /* tomix */, .4 /* gain */);
  spork ~ BASS ("*4  __11__11__1!1__11  __11__11__1!1_1_1  __11__11__1!1__11  __11__11__1!1_3_1 "); 
  spork ~ GLITCH(" }c +7 m//F__ F/mm/F " /* seq */,  "*8 11" /* seq_cutter */,  "*4  1" /* seq_arp */, 24 /* instru */);
  spork ~ GLITCH(" }c -2  ____ ____ *4 1_1_1_1_1_1_1_1_1_1_1_1_" /* seq */,  "*8 1" /* seq_cutter */,  "*4  18f" /* seq_arp */, 25 /* instru */);

  16 * data.tick =>  w.wait; 

  spork ~ TRANCE ("kkkk kkkk kkkk kk*4k_kk_kkk:4"); 
  spork ~ TRIBAL("*4 __h_ s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_  __h_ s_h_ __h_ s_h_ __h_ s_h_ __h_ s_h_ ", 2 /* bank */, 0 /* tomix */, .4 /* gain */);
  spork ~ TRIBAL("*4 _aaa _a_a _bb_ _b_b _aaa _a_a _bb_ _b_b_aaa _a_a _bb_ _b_b_aaa _a_a _bb_ _b_b", 2 /* bank */, 0 /* tomix */, .4 /* gain */);
  spork ~ BASS ("*4  __11__11__1!1__11  __11__11__1!1_1_1  __11__11__1!1__11  __11__11__*2 8_5_3_1_ 1111 "); 
  spork ~ GLITCH(" }c +7 f////M " /* seq */,  "*8 1" /* seq_cutter */,  "*4  18" /* seq_arp */, 24 /* instru */);
  spork ~ GLITCH(" }c -2  ____ __f////M M//m" /* seq */,  "*8 1" /* seq_cutter */,  "*4  18f" /* seq_arp */, 25 /* instru */);

  12 * data.tick =>  w.wait; 
  spork ~ TRIBAL("*4 cdbacbd ", 1 /* bank */, 1 /* tomix */, 0.9 /* gain */);
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

// END

  spork ~   SINGLEWAVRATE("../_SAMPLES/IlesMarquises/conque.wav", 1.0, 0.6); 
  10 * data.tick =>  w.wait;

   //// STOP REC ///////////////////////////////
  if (rec_mode) {     
    // Note extra time to add above
    strecend.rec_stop( 0::ms, 1);
    strecendaux.rec_stop( 0::ms, 1);
    2::ms => now;
  }
//////////////////////////////////////////////////


}

