//--------------------------------------------------------------------
// SpectralSynth test — load audio, pitch shift, and play
//--------------------------------------------------------------------

// load a sound file into a SndBuf
SndBuf buf => blackhole;
"../_SAMPLES/SYNTWAVS/Breathchoir19.wav" => buf.read;
//"../_SAMPLES/SYNTWAVS/AnalogStr19.wav" => buf.read;
//"../_SAMPLES/SYNTWAVS/Agitato53.wav" => buf.read;
//"../_SAMPLES/SYNTWAVS/AnaOrch18.wav" => buf.read;
//"../_SAMPLES/SYNTWAVS/MELLOTRON_StringSection_43.wav" => buf.read;
//"../_SAMPLES/SYNTWAVS/MULTI2GENTLESPEECH046.wav" => buf.read;
//"../_SAMPLES/SYNTWAVS/MULTI2GROAN044.wav" => buf.read;
//"../_SAMPLES/TurkishVoices/AhAhAhAaaaah.wav" => buf.read;
//"../_SAMPLES/Whales/baleine1.wav" => buf.read;

// extract samples into a float array
float samples[buf.samples()];
for( 0 => int i; i < buf.samples(); i++ )
    buf.valueAt(i) => samples[i];

// create SpectralSynth and connect to dac
SpectralSynth ss => dac;

// load the audio buffer
ss.input( samples );

//buf => dac;
//0 => buf.pos;
//(buf.samples()::samp) => now;


// --- test 1: pitch shift up 5 semitones ---
<<< "test 1: pitch shift +5 semitones" >>>;
ss.pitchShift( 0.0 );
ss.play();
ss.loop( 1 );
ss.crossfade( 32 * 2048 );
(buf.samples()::samp) * 4 => now;

// --- test 2: pitch shift down 7 semitones ---
<<< "test 2: pitch shift -7 semitones" >>>;
ss.pitchShift( -7.0 );
ss.play();
(buf.samples()::samp) => now;

// --- test 3: robotize ---
<<< "test 3: robotize" >>>;
ss.pitchShift( 0.0 );
ss.robotize( 1 );
ss.play();
(buf.samples()::samp) => now;
ss.robotize( 0 );

// --- test 4: whisperize ---
<<< "test 4: whisperize" >>>;
ss.whisperize( 1 );
ss.play();
(buf.samples()::samp) => now;
ss.whisperize( 0 );

// --- test 5: spectral blur ---
<<< "test 5: spectral blur" >>>;
ss.spectralBlur( 2.0 );
ss.play();
(buf.samples()::samp) => now;
ss.spectralBlur( 0.0 );

// --- test 6: spectral gate ---
<<< "test 6: spectral gate (keep strongest partials)" >>>;
ss.spectralGate( 0.3 );
ss.play();
(buf.samples()::samp) => now;
ss.spectralGate( 0.0 );

// --- test 7: freeze ---
<<< "test 7: freeze" >>>;
ss.freeze( 1 );
ss.loop( 1 );
ss.play();
3::second => now;

<<< "done." >>>;
