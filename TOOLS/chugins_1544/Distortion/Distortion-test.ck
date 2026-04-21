//--------------------------------------------------------------------
// Distortion-test.ck
// Tests all 14 distortion algorithms of the Distortion chugin.
// Each mode plays a sine wave for 1 second with representative settings.
//--------------------------------------------------------------------

// sine wave source
SinOsc src => Distortion dist => dac;
440.0 => src.freq;
0.8   => src.gain;   // drive it a bit to hear the distortion

// helper: pause, print mode name, apply settings, play
fun void testMode( string name, int modeval )
{
    <<< "---", name, "(mode", modeval, ")" >>>;
    dist.mode( modeval );
    3::second => now;
}

while(1) {
 
//--------------------------------------------------------------------
// 0: Hard Clipping
// Sharp clip at ±threshold — lots of odd harmonics
//--------------------------------------------------------------------
dist.gainIn( 2.0 );          // push into clipping
dist.gain( 0.5 );
dist.threshold( 0.5 );       // clip at 0.5
testMode( "HARD_CLIP", Distortion.HARD_CLIP );

//--------------------------------------------------------------------
// 1: Soft Clipping
// Smooth cubic knee; knee=1 → fully smooth, knee=0 → hard clip
//--------------------------------------------------------------------
dist.gainIn( 2.0 );
dist.gain( 0.6 );
dist.threshold( 0.6 );
dist.knee( 0.8 );            // wide smooth knee
testMode( "SOFT_CLIP", Distortion.SOFT_CLIP );

//--------------------------------------------------------------------
// 2: Foldback
// Signal mirrors when it exceeds foldThreshold — metallic harmonics
//--------------------------------------------------------------------
dist.gainIn( 3.0 );
dist.gain( 0.5 );
dist.foldThreshold( 0.4 );   // fold point
testMode( "FOLDBACK", Distortion.FOLDBACK );

//--------------------------------------------------------------------
// 3: Tube Distortion
// Asymmetric tanh — warm even harmonics, valve character
//--------------------------------------------------------------------
dist.gainIn( 1.5 );
dist.gain( 0.7 );
dist.bias( 0.15 );           // asymmetric bias
dist.warmth( 0.6 );          // even-harmonic blend
testMode( "TUBE", Distortion.TUBE );

//--------------------------------------------------------------------
// 4: Arctangent
// Smooth, musical atan saturation; drive controls amount
//--------------------------------------------------------------------
dist.gainIn( 1.0 );
dist.gain( 0.8 );
dist.drive( 8.0 );           // higher drive = more saturation
testMode( "ARCTANGENT", Distortion.ARCTANGENT );

//--------------------------------------------------------------------
// 5: Amp Simulation
// Three-stage model: preamp + power amp + tone stack + presence
//--------------------------------------------------------------------
dist.gainIn( 1.5 );
dist.gain( 0.6 );
dist.tone( 0.6 );            // slightly bright tone stack
dist.presence( 0.4 );        // moderate presence boost
testMode( "AMPSIM", Distortion.AMPSIM );

//--------------------------------------------------------------------
// 6: Overdrive
// Exponential clipping — Tube Screamer-style asymmetric OD
//--------------------------------------------------------------------
dist.gainIn( 1.5 );
dist.gain( 0.7 );
dist.drive( 6.0 );           // OD drive amount
dist.bias( 0.1 );            // slight asymmetry
testMode( "OVERDRIVE", Distortion.OVERDRIVE );

//--------------------------------------------------------------------
// 7: Fuzz
// High-gain hard clip + tone filter — Fuzz Face character
//--------------------------------------------------------------------
dist.gainIn( 1.0 );
dist.gain( 0.5 );
dist.tone( 0.4 );            // roll off some highs for classic fuzz sound
testMode( "FUZZ", Distortion.FUZZ );

//--------------------------------------------------------------------
// 8: Bitcrush
// Bit-depth reduction — lo-fi quantisation artefacts
//--------------------------------------------------------------------
dist.gainIn( 1.0 );
dist.gain( 0.8 );
dist.bits( 4.0 );            // 4-bit → very noticeable quantisation steps
testMode( "BITCRUSH", Distortion.BITCRUSH );

//--------------------------------------------------------------------
// 9: Waveshaper
// Cubic-to-sine Chebyshev blend; shape controls harmonic content
//--------------------------------------------------------------------
dist.gainIn( 1.0 );
dist.gain( 0.8 );
dist.shape( 1.5 );           // between cubic and sinusoidal fold
testMode( "WAVESHAPER", Distortion.WAVESHAPER );

//--------------------------------------------------------------------
// 10: Diode Clipper
// Asymmetric exponential clipping — asymmetry controls imbalance
//--------------------------------------------------------------------
dist.gainIn( 1.5 );
dist.gain( 0.7 );
dist.asymmetry( 0.7 );       // strong asymmetry → rich even harmonics
testMode( "DIODE", Distortion.DIODE );

//--------------------------------------------------------------------
// 11: Sigmoid
// Logistic S-curve — symmetric smooth saturation; slope = steepness
//--------------------------------------------------------------------
dist.gainIn( 1.0 );
dist.gain( 0.9 );
dist.slope( 10.0 );          // steeper slope = more aggressive saturation
testMode( "SIGMOID", Distortion.SIGMOID );

//--------------------------------------------------------------------
// 12: Sinefold
// Maps signal through sine — soft clip at low levels, rich folding at high
//--------------------------------------------------------------------
dist.gainIn( 2.5 );
dist.gain( 0.8 );
dist.threshold( 0.5 );       // normalisation scale
dist.foldFreq( 2.0 );        // two folds — more complex spectrum
testMode( "SINEFOLD", Distortion.SINEFOLD );

//--------------------------------------------------------------------
// 13: Decimator
// Sample & hold — reduced effective sample rate, aliasing artefacts
//--------------------------------------------------------------------
dist.gainIn( 1.0 );
dist.gain( 0.9 );
dist.sampleHold( 0.9 );      // hold for ~10 samples → strong decimation
testMode( "DECIMATOR", Distortion.DECIMATOR );

//--------------------------------------------------------------------
// Demo: sweep gainIn through TUBE mode
//--------------------------------------------------------------------
<<< "--- Tube sweep: gainIn 0.5 → 4.0 ---" >>>;
dist.mode( Distortion.TUBE );
dist.bias( 0.1 );
dist.warmth( 0.5 );
dist.gain( 0.6 );
for( 0 => int i; i <= 10; i++ )
{
    0.5 + (3.5 * i / 10.0) => float gi;
    dist.gainIn( gi );
    <<< "  gainIn =", gi >>>;
    250::ms => now;
}

<<< "done." >>>;
}
