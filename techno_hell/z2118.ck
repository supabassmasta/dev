class SERUM2 extends SYNT{

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
  
  0 => int chunk_size;
  0 => int chunk_nb;

  fun void config(int wn /* wave number */) {

//    ROOTPATH.str.my_string + "_SAMPLES/wavetable/TriSamples Wavetables For Serum/M3-Analog-Electric/"
//    ROOTPATH.str.my_string + "_SAMPLES/wavetable/TriSamples Wavetables For Serum/M5-FX-Chords/01-Camchord.wav"

    string st[0];
    int chunks[0];
/* 0 */    st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0001-64.wav"; chunks << 64;
/* 2 */    st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0002-64.wav"; chunks << 64;
/* 3 */    st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0003-64.wav"; chunks << 64;
/* 4 */    st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0004-64.wav"; chunks << 64;
/* 5 */    st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0005-64.wav"; chunks << 64;
/* 6 */    st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0006-64.wav"; chunks << 64;
/* 7 */    st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0007-64.wav"; chunks << 64;
/* 8 */    st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0008-64.wav"; chunks << 64;
/* 9 */    st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0009-64.wav"; chunks << 64;
/* 10 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0010-64.wav"; chunks << 64;
/* 11 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0011-64.wav"; chunks << 64;
/* 12 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0012-64.wav"; chunks << 64;
/* 13 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0013-64.wav"; chunks << 64;
/* 14 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0014-64.wav"; chunks << 64;
/* 15 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0015-64.wav"; chunks << 64;
/* 16 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0016-64.wav"; chunks << 64;
/* 17 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0017-64.wav"; chunks << 64;
/* 18 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0018-64.wav"; chunks << 64;
/* 19 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0019-64.wav"; chunks << 64;
/* 20 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0020-64.wav"; chunks << 64;
/* 21 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0021-64.wav"; chunks << 64;
/* 22 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0022-64.wav"; chunks << 64;
/* 23 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0023-64.wav"; chunks << 64;
/* 24 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0024-64.wav"; chunks << 64;
/* 25 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0025-64.wav"; chunks << 64;
/* 26 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0026-64.wav"; chunks << 64;
/* 27 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0027-64.wav"; chunks << 64;
/* 28 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0028-64.wav"; chunks << 64;
/* 29 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0029-64.wav"; chunks << 64;
/* 30 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0030-64.wav"; chunks << 64;
/* 31 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0031-64.wav"; chunks << 64;
/* 32 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_0032-32.wav"; chunks << 32;
/* 33 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_Pure_4.wav";  chunks << 4;
/* 34 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_R_asym_saw_48.wav"; chunks << 48;
/* 35 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_aguitar_24.wav"; chunks << 24;
/* 36 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_aguitar_32.wav"; chunks << 32;
/* 37 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_altosax_24.wav"; chunks << 24;
/* 38 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_birds_12.wav"; chunks << 12;
/* 39 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_bitreduced_64.wav"; chunks << 64;
/* 40 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_blended_64.wav"; chunks << 64;
/* 41 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_bsaw_8.wav"; chunks << 8;
/* 42 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_cello_16.wav"; chunks << 16;
/* 43 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_clarinett_16.wav"; chunks << 16;
/* 44 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_clavinet_32.wav"; chunks << 32;
/* 45 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_dbass_64.wav"; chunks << 64;
/* 46 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_distorted_32.wav"; chunks << 32;
/* 47 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_ebass_64.wav"; chunks << 64;
/* 48 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_eguitar_16.wav"; chunks << 16;
/* 49 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_eorgan2_64.wav"; chunks << 64;
/* 50 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_eorgan_64.wav"; chunks << 64;
/* 51 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_epiano_64.wav"; chunks << 64;
/* 52 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_flute_16.wav"; chunks << 16;
/* 53 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_fmsynth_48.wav"; chunks << 48;
/* 54 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_fmsynth_64.wav"; chunks << 64;
/* 55 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_gapsaw_32.wav"; chunks << 32;
/* 56 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_granular_32.wav"; chunks << 32;
/* 57 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_hdrawn_48.wav"; chunks << 48;
/* 58 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_hvoice_32.wav"; chunks << 32;
/* 59 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_hvoice_64.wav"; chunks << 64;
/* 60 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_linear_16.wav"; chunks << 16;
/* 61 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_linear_64.wav"; chunks << 64;
/* 62 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_oboe_8.wav"; chunks << 8;
/* 63 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_oscchip2_64.wav"; chunks << 64;
/* 64 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_oscchip_64.wav"; chunks << 64;
/* 65 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_overtone_32.wav"; chunks << 32;
/* 66 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_piano_24.wav"; chunks << 24;
/* 67 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_pluckalgo_8.wav"; chunks << 8;
/* 68 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_rAsymSqu_48.wav"; chunks << 48;
/* 69 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_raw_32.wav"; chunks << 32;
/* 70 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_saw_48.wav"; chunks << 48;
/* 71 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_sin_12.wav"; chunks << 12;
/* 72 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_sinharm_16.wav"; chunks << 16;
/* 73 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_snippet_32.wav"; chunks << 32;
/* 74 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_squ_32.wav"; chunks << 32;
/* 75 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_squ_64.wav"; chunks << 64;
/* 75 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_stereo1_64.wav"; chunks << 64;
/* 76 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_stereo2_64.wav"; chunks << 64;
/* 77 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_stereo3_64.wav"; chunks << 64;
/* 78 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_stereo_64.wav"; chunks << 64;
/* 79 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_symetric_16.wav"; chunks << 16;
/* 80 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_theremin_16.wav"; chunks << 16;
/* 81 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_tri_24.wav"; chunks << 24;
/* 82 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_vgame2_64.wav"; chunks << 64;
/* 83 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_vgame_64.wav"; chunks << 64;
/* 84 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_vgame_8.wav"; chunks << 8;
/* 85 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_vgsaw_64.wav"; chunks << 64;
/* 86 */   st << ROOTPATH.str.my_string + "_SAMPLES/wavetable/Inspektor_Gadjet.AK_WaveForms_&_Slices/Sample Chains in C/AKWF_violin_12.wav"; chunks << 12;
    
   if ( wn >= st.size()  ){
       <<<"SERUM: WARNING WAVTABLE NUMER TOO HIGH">>>;
       0 => wn;
   }
   else {
      <<<"serum wavtable :", wn, st[wn], " Chunks : ", chunks[wn]>>>;
   }

   st[wn] => s.read;

  // Get chunk size
  chunks[wn] => chunk_nb;
  s.samples() / chunk_nb => chunk_size;

    for (0 => int i; i < s.samples() ; i++) {
      myTable << s.valueAt(i);
    }

    if ( myTable.size() == 0  ){
       <<<" SERUM ERROR: Empty wavtable !!!!!">>>;

       myTable << 0; 
    }

    w.setTable (myTable);
  }

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


TONE t;
t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(0 /* synt nb */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"1_" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


while(1) {
       100::ms => now;
}
 
