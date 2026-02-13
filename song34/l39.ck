 0 =>int mixer;

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

fun void  SPECTR (int note, int nfile, float pitchShift, int robotize, int whisperize,float spectralBlur,float spectralGate,dur att, dur rel, dur d, int tomix, float v){ 
  SndBuf buf => blackhole;
  syntwavs_files(nfile) + note + ".wav" => buf.read;
  buf.samples() => buf.pos;
  // extract samples into a float array
  float samples[buf.samples()];
  for( 0 => int i; i < buf.samples(); i++ ){
//  100 * 4096 => int max_samples;//
//  0 => int len;
//  if (buf.samples() > max_samples) max_samples => len; else buf.samples() => len;
//  float samples[len];
//  for( 0 => int i; i < len; i++ ){
    buf.valueAt(i) => samples[i];
    me.yield();
  }

  // TOREMOVE
//  1::second => now;

  ST stmonoin; stmonoin $ ST @=> ST @ last;

  STADSR stadsr;
  stadsr.set(att /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */,0.0/* Sustain dur of Relative release pos (float) */,  rel /* release */);
  stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 

  SpectralSynth ss => stmonoin.mono_in ;
  //4096 => ss.fftSize;
  //8 => ss.overlap;
  // load the audio buffer
  ss.input( samples );
  ss.pitchShift( pitchShift );
  ss.robotize( robotize );
  ss.whisperize( whisperize );
  ss.spectralBlur( spectralBlur );
  ss.spectralGate( spectralGate );
  ss.loop( 1 );
  ss.crossfade(4 * 2048 );
  v * data.master_gain => ss.gain;

  ss.play();
  stadsr.keyOn(); 

  if ( tomix  ){
    STMIX stmix;
    stmix.send(last, mixer + tomix);
  }

  d => now;
  stadsr.keyOff(); 
  rel => now;
  ss.stop();
} 


///////////////////////////////

STMIX stmix;
//stmix.send(last, 11);
stmix.receive(mixer + 1); stmix $ ST @=> ST @ last; 

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 2 /* freq */); 

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 14/* ir index */, 2 /* chans */, 10::ms /* pre delay*/, .1 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

while(1) {
spork ~ SPECTR (24/*note*/,19/*file*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,2000::ms/*att*/,20000::ms/*rel*/, 20::second, 0, 1.7); 
23::second => now;
spork ~ SPECTR (24/*note*/,17/*file*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1000::ms/*att*/,20000::ms/*rel*/, 40::second, 0, 0.3); 
23::second => now;
spork ~ SPECTR (24/*note*/,30/*file*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1000::ms/*att*/,20000::ms/*rel*/, 20::second, 0, 0.3); 
11::second => now;
spork ~ SPECTR (24/*note*/,26/*file*/,0./*semiToneShift*/,0/*robotize*/,1/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,1000::ms/*att*/,20000::ms/*rel*/, 13::second, 0, 0.4); 
23::second => now;
}
 



fun void seq0   (){ 
   

/// PLAY OR REC /////////////////
RECSEQ recseq; "seqname0.wav"=>recseq.name_main; 0=>recseq.compute_mode; 1=>recseq.rec_mode;10::second=>recseq.main_extra_time;1.=>recseq.play_gain;
if (recseq.play_or_rec() ) {
  //////////////////////////////////

  //////////////////////////////////////////////////
  // MAIN 
  //////////////////////////////////////////////////

spork ~ SPECTR (18/*note*/,17/*file*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,10000::ms/*att*/,20000::ms/*rel*/, 40::second, 0, 0.3); 
10::second => now;
spork ~ SPECTR (18/*note*/,17/*file*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.2/*spectralGate*/,10000::ms/*att*/,20000::ms/*rel*/, 40::second, 0, 1.0); 
10::second => now;
spork ~ SPECTR (23/*note*/,17/*file*/,-2./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.2/*spectralBlur*/,0.2/*spectralGate*/,10000::ms/*att*/,20000::ms/*rel*/, 40::second, 0, 1.0); 
20::second => now;
spork ~ SPECTR (25/*note*/,19/*file*/,0./*semiToneShift*/,0/*robotize*/,0/*whisperize*/,0.0/*spectralBlur*/,0.0/*spectralGate*/,10000::ms/*att*/,20000::ms/*rel*/, 20::second, 0, 1.0); 
40::second => now;


  //// STOP REC ///////////////////////////////
  recseq.rec_stop();
  //////////////////////////////////////////////////
} 
}
    if (! MISC.file_exist( "seqname0.wav")) seq0();
 
LOOP_DOUBLE_WAV l;
"seqname0.wav" => l.read;
1.0 * data.master_gain => l.buf.gain => l.buf2.gain;
l.AttackRelease(1::ms, 15 * 100::ms);
l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */ , l.buf.length() - 20::second /* loop */); // l $ ST @=> ST @ last;   

while(1) {
       100::ms => now;
}
 
