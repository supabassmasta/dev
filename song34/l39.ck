fun void  SPECTR (dur d, int tomix, float v){ 
SndBuf buf => blackhole;
"../_SAMPLES/SYNTWAVS/Breathchoir19.wav" => buf.read;
//"../_SAMPLES/SYNTWAVS/AnalogStr19.wav" => buf.read;
//"../_SAMPLES/SYNTWAVS/Agitato53.wav" => buf.read;
//"../_SAMPLES/SYNTWAVS/AnaOrch48.wav" => buf.read;
//"../_SAMPLES/SYNTWAVS/MELLOTRON_StringSection_43.wav" => buf.read;
//"../_SAMPLES/SYNTWAVS/MULTI2GENTLESPEECH046.wav" => buf.read;
//"../_SAMPLES/SYNTWAVS/MULTI2GROAN044.wav" => buf.read;
//"../_SAMPLES/TurkishVoices/AhAhAhAaaaah.wav" => buf.read;
//"../_SAMPLES/Whales/baleine1.wav" => buf.read;

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


spork ~   SPECTR (41::second, 0, 1.0); 

while(1) {
       100::ms => now;
}
 
