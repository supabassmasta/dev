//--------------------------------------------------------------------
// SpectralSynth test — load audio, pitch shift, and play
//--------------------------------------------------------------------

// load a sound file into a SndBuf
SndBuf buf => blackhole;
"special:dope" => buf.read;

// extract samples into a float array
float samples[buf.samples()];
for( 0 => int i; i < buf.samples(); i++ )
    buf.valueAt(i) => samples[i];

// create SpectralSynth and connect to dac
SpectralSynth ss => dac;

// load the audio buffer
ss.input( samples );

// --- test 1: pitch shift up 5 semitones ---
<<< "test 1: pitch shift +5 semitones" >>>;
ss.pitchShift( 5.0 );
ss.play();
(buf.samples()::samp) => now;

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
ss.stop();
ss.freeze( 0 );
ss.loop( 0 );

// --- test 8: incremental processing ---
<<< "test 8: incremental processing (pitch +5)" >>>;
ss.pitchShift( 5.0 );
ss.prepare();
<<< "  numFrames:", ss.numFrames() >>>;

// process in batches of 50 frames, yielding between each
while( ss.ready() == 0 )
{
    ss.processFrames( 50 );
    1::samp => now;
}
<<< "  ready:", ss.ready() >>>;

ss.play();
(buf.samples()::samp) => now;

<<< "done." >>>;
