fun string syntwavs_files (int i) {
string str[0];    
/* 0 */    str << "../_SAMPLES/SYNTWAVS/MULTI2SIN0";
/* 1 */    str << "../_SAMPLES/SYNTWAVS/MULTI2SIN1";
/* 2 */    str << "../_SAMPLES/SYNTWAVS/MULTI2SIN2";
/* 3 */    str << "../_SAMPLES/SYNTWAVS/MULTI2GROAN0";
/* 4 */    str << "../_SAMPLES/SYNTWAVS/MULTI2GROAN1";
/* 5 */    str << "../_SAMPLES/SYNTWAVS/MULTI2GENTLESPEECH0";
/* 6 */    str << "../_SAMPLES/SYNTWAVS/MULTI2GENTLESPEECH1";
/* 7 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_Cello_";
/* 8 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_CombinedChoir_";
/* 9 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_GC3Brass_";
/* 10 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_M300B_";
/* 11 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_MkIIBrass_";
/* 12 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_MkIIFlute_";
/* 13 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_MkIIViolins_";
/* 14 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_StringSection_";
/* 15 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_Woodwind2_";
/* 16 */    str<<"../_SAMPLES/SYNTWAVS/Agitato";
/* 17 */    str<<"../_SAMPLES/SYNTWAVS/Breathchoir";
/* 18 */    str<<"../_SAMPLES/SYNTWAVS/FlangOrg";
/* 19 */    str<<"../_SAMPLES/SYNTWAVS/Stalactite";
/* 20 */    str<<"../_SAMPLES/SYNTWAVS/AnalogStr";
/* 21 */    str<<"../_SAMPLES/SYNTWAVS/BriteString";
/* 22 */    str<<"../_SAMPLES/SYNTWAVS/FreezePad";
/* 23 */    str<<"../_SAMPLES/SYNTWAVS/Neptune";
/* 24 */    str<<"../_SAMPLES/SYNTWAVS/AnaOrch";
/* 25 */    str<<"../_SAMPLES/SYNTWAVS/ClearBell";
/* 26 */    str<<"../_SAMPLES/SYNTWAVS/GlassChoir";
/* 27 */    str<<"../_SAMPLES/SYNTWAVS/No.9String";
/* 28 */    str<<"../_SAMPLES/SYNTWAVS/Telesa";
/* 29 */    str<<"../_SAMPLES/SYNTWAVS/AnLayer";
/* 30 */    str<<"../_SAMPLES/SYNTWAVS/CloudNine";
/* 31 */    str<<"../_SAMPLES/SYNTWAVS/GlassMan";
/* 32 */    str<<"../_SAMPLES/SYNTWAVS/Phasensemble";
/* 33 */    str<<"../_SAMPLES/SYNTWAVS/VelocityEns";
/* 34 */    str<<"../_SAMPLES/SYNTWAVS/Apollo";
/* 35 */    str<<"../_SAMPLES/SYNTWAVS/ComeOnHigh";
/* 36 */    str<<"../_SAMPLES/SYNTWAVS/HollowPad";
/* 37 */    str<<"../_SAMPLES/SYNTWAVS/PulseString";
/* 38 */    str<<"../_SAMPLES/SYNTWAVS/BigStrings+";
/* 39 */    str<<"../_SAMPLES/SYNTWAVS/Dreamsphere";
/* 40 */    str<<"../_SAMPLES/SYNTWAVS/Kemuri";
/* 41 */    str<<"../_SAMPLES/SYNTWAVS/SkyOrgan";
/* 42 */    str<<"../_SAMPLES/SYNTWAVS/BigWave";
/* 43 */    str<<"../_SAMPLES/SYNTWAVS/DynaPWM";
/* 44 */    str<<"../_SAMPLES/SYNTWAVS/SmokePad";
/* 45 */    str<<"../_SAMPLES/SYNTWAVS/BottledOut";
/* 46 */    str<<"../_SAMPLES/SYNTWAVS/EnsembleMix";
/* 47 */    str<<"../_SAMPLES/SYNTWAVS/Mars";
/* 48 */    str<<"../_SAMPLES/SYNTWAVS/SoftString";
/* 49 */    str<<"../_SAMPLES/SYNTWAVS/StereoString";
/* 50 */    str<<"../_SAMPLES/SYNTWAVS/MellowStrings";

    if ( i >= str.size() ){
      <<<"ERROR SYNTWAV : FILE number TOO HIGH">>>;
      0=> i; 
    }

    <<<"LOADING ", str [i] >>>;

    return str[i]; 
}

fun void  SPECTR (int note, int nfile, dur d, int tomix, float v){ 
  SndBuf buf => blackhole;

  syntwavs_files(nfile) + note + ".wav" => buf.read;

  // extract samples into a float array
  float samples[buf.samples()];
  for( 0 => int i; i < buf.samples(); i++ )
    buf.valueAt(i) => samples[i];

  SpectralSynth ss => dac;
  //4096 => ss.fftSize;
  //8 => ss.overlap;
  // load the audio buffer
  ss.input( samples );

  ss.pitchShift( 0.0 );
  ss.loop( 1 );
  ss.crossfade( 32 * 2048 );
  ss.play();

  v * data.master_gain => ss.gain;

  if ( tomix  ){
    //    STMIX stmix;
    ////    stmix.send(last, mixer + tomix);
  }

  d => now;
  ss.stop();
} 


spork ~   SPECTR (56, 14, 41::second, 0, 1.0); 

while(1) {
       100::ms => now;
}
 
