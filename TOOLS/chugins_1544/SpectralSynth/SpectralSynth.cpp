//-----------------------------------------------------------------------------
// SpectralSynth — FFT-based spectral resynthesis chugin for ChucK
// Phase vocoder with pitch shifting and spectral effects
//-----------------------------------------------------------------------------

#include "chugin.h"
#include "AudioFFT.h"

#include <cmath>
#include <cstring>
#include <cstdlib>
#include <vector>
#include <algorithm>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif


//-----------------------------------------------------------------------------
// forward declarations
//-----------------------------------------------------------------------------
CK_DLL_CTOR( spectralsynth_ctor );
CK_DLL_DTOR( spectralsynth_dtor );
CK_DLL_TICK( spectralsynth_tick );

// input
CK_DLL_MFUN( spectralsynth_input );

// transport
CK_DLL_MFUN( spectralsynth_play );
CK_DLL_MFUN( spectralsynth_stop );

// parameter setters/getters
CK_DLL_MFUN( spectralsynth_setPitchShift );
CK_DLL_MFUN( spectralsynth_getPitchShift );
CK_DLL_MFUN( spectralsynth_setFftSize );
CK_DLL_MFUN( spectralsynth_getFftSize );
CK_DLL_MFUN( spectralsynth_setOverlap );
CK_DLL_MFUN( spectralsynth_getOverlap );
CK_DLL_MFUN( spectralsynth_setLoop );
CK_DLL_MFUN( spectralsynth_getLoop );
CK_DLL_MFUN( spectralsynth_setPos );
CK_DLL_MFUN( spectralsynth_getPos );
CK_DLL_MFUN( spectralsynth_setGain );
CK_DLL_MFUN( spectralsynth_getGain );
CK_DLL_MFUN( spectralsynth_setCrossfade );
CK_DLL_MFUN( spectralsynth_getCrossfade );

// spectral effects setters/getters
CK_DLL_MFUN( spectralsynth_setFreeze );
CK_DLL_MFUN( spectralsynth_getFreeze );
CK_DLL_MFUN( spectralsynth_setRobotize );
CK_DLL_MFUN( spectralsynth_getRobotize );
CK_DLL_MFUN( spectralsynth_setWhisperize );
CK_DLL_MFUN( spectralsynth_getWhisperize );
CK_DLL_MFUN( spectralsynth_setSpectralBlur );
CK_DLL_MFUN( spectralsynth_getSpectralBlur );
CK_DLL_MFUN( spectralsynth_setSpectralGate );
CK_DLL_MFUN( spectralsynth_getSpectralGate );
CK_DLL_MFUN( spectralsynth_setFormantShift );
CK_DLL_MFUN( spectralsynth_getFormantShift );

t_CKINT spectralsynth_data_offset = 0;


//-----------------------------------------------------------------------------
// helper: check power of 2
//-----------------------------------------------------------------------------
static bool isPowerOf2( int v )
{
    return v > 0 && (v & (v - 1)) == 0;
}


//-----------------------------------------------------------------------------
// SpectralSynth C++ class
//-----------------------------------------------------------------------------
class SpectralSynth
{
public:
    SpectralSynth( t_CKFLOAT fs )
    : m_srate( fs )
    , m_fftSize( 2048 )
    , m_overlapFactor( 4 )
    , m_pitchShift( 0.0 )
    , m_gain( 1.0 )
    , m_loop( false )
    , m_playing( false )
    , m_freeze( false )
    , m_robotize( false )
    , m_whisperize( false )
    , m_spectralBlur( 0.0 )
    , m_spectralGate( 0.0 )
    , m_formantShift( 0.0 )
    , m_readPos( 0 )
    , m_crossfadeLen( 1024 )
    , m_dirty( false )
    {
        updateParams();
    }

    ~SpectralSynth()
    {
    }

    //--- input ---
    void setInput( const std::vector<float> & audio )
    {
        m_inputBuf = audio;
        m_dirty = true;
        resynthesize();
    }

    //--- transport ---
    void play()
    {
        if( m_dirty ) resynthesize();
        m_readPos = 0;
        m_playing = true;
    }

    void stop()
    {
        m_playing = false;
    }

    //--- tick ---
    SAMPLE tick( SAMPLE in )
    {
        if( !m_playing || m_outputBuf.empty() )
            return 0.0;

        t_CKINT bufLen = (t_CKINT)m_outputBuf.size();
        SAMPLE out = (SAMPLE)m_outputBuf[m_readPos];

        // crossfade for seamless looping
        if( m_loop && m_crossfadeLen > 0 )
        {
            t_CKINT fadeStart = bufLen - m_crossfadeLen;
            if( fadeStart < 0 ) fadeStart = 0;

            if( m_readPos >= fadeStart )
            {
                // how far into the crossfade region (0.0 to 1.0)
                float fadePos = (float)(m_readPos - fadeStart) / (float)m_crossfadeLen;
                // equal-power crossfade
                float fadeOut = cosf( fadePos * 0.5f * (float)M_PI );
                float fadeIn  = sinf( fadePos * 0.5f * (float)M_PI );
                // corresponding position at the start of the buffer
                t_CKINT headPos = m_readPos - fadeStart;
                if( headPos < bufLen )
                    out = out * fadeOut + m_outputBuf[headPos] * fadeIn;
            }
        }

        out *= (SAMPLE)m_gain;
        m_readPos++;

        if( m_readPos >= bufLen )
        {
            if( m_loop )
            {
                // jump past the crossfade region we already blended in
                t_CKINT fadeLen = m_crossfadeLen;
                if( fadeLen > bufLen ) fadeLen = bufLen;
                m_readPos = fadeLen;
            }
            else
                m_playing = false;
        }

        return out;
    }

    //--- parameters ---
    t_CKFLOAT setPitchShift( t_CKFLOAT semitones )
    {
        m_pitchShift = semitones;
        m_dirty = true;
        return m_pitchShift;
    }
    t_CKFLOAT getPitchShift() { return m_pitchShift; }

    t_CKINT setFftSize( t_CKINT size )
    {
        if( isPowerOf2( (int)size ) && size >= 64 )
        {
            m_fftSize = (int)size;
            updateParams();
            m_dirty = true;
        }
        return (t_CKINT)m_fftSize;
    }
    t_CKINT getFftSize() { return (t_CKINT)m_fftSize; }

    t_CKINT setOverlap( t_CKINT factor )
    {
        if( factor == 2 || factor == 4 || factor == 8 )
        {
            m_overlapFactor = (int)factor;
            updateParams();
            m_dirty = true;
        }
        return (t_CKINT)m_overlapFactor;
    }
    t_CKINT getOverlap() { return (t_CKINT)m_overlapFactor; }

    t_CKINT setLoop( t_CKINT v ) { m_loop = (v != 0); return m_loop ? 1 : 0; }
    t_CKINT getLoop() { return m_loop ? 1 : 0; }

    t_CKINT setPos( t_CKINT p )
    {
        if( p >= 0 && p < (t_CKINT)m_outputBuf.size() )
            m_readPos = p;
        return m_readPos;
    }
    t_CKINT getPos() { return m_readPos; }

    t_CKFLOAT setGain( t_CKFLOAT g ) { m_gain = g; return m_gain; }
    t_CKFLOAT getGain() { return m_gain; }

    t_CKINT setCrossfade( t_CKINT samples )
    {
        if( samples >= 0 ) m_crossfadeLen = samples;
        return m_crossfadeLen;
    }
    t_CKINT getCrossfade() { return m_crossfadeLen; }

    //--- spectral effects ---
    t_CKINT setFreeze( t_CKINT v )
    {
        m_freeze = (v != 0);
        m_dirty = true;
        return m_freeze ? 1 : 0;
    }
    t_CKINT getFreeze() { return m_freeze ? 1 : 0; }

    t_CKINT setRobotize( t_CKINT v )
    {
        m_robotize = (v != 0);
        m_dirty = true;
        return m_robotize ? 1 : 0;
    }
    t_CKINT getRobotize() { return m_robotize ? 1 : 0; }

    t_CKINT setWhisperize( t_CKINT v )
    {
        m_whisperize = (v != 0);
        m_dirty = true;
        return m_whisperize ? 1 : 0;
    }
    t_CKINT getWhisperize() { return m_whisperize ? 1 : 0; }

    t_CKFLOAT setSpectralBlur( t_CKFLOAT v )
    {
        m_spectralBlur = std::max( 0.0, v );
        m_dirty = true;
        return m_spectralBlur;
    }
    t_CKFLOAT getSpectralBlur() { return m_spectralBlur; }

    t_CKFLOAT setSpectralGate( t_CKFLOAT v )
    {
        m_spectralGate = std::max( 0.0, std::min( 1.0, v ) );
        m_dirty = true;
        return m_spectralGate;
    }
    t_CKFLOAT getSpectralGate() { return m_spectralGate; }

    t_CKFLOAT setFormantShift( t_CKFLOAT v )
    {
        m_formantShift = v;
        m_dirty = true;
        return m_formantShift;
    }
    t_CKFLOAT getFormantShift() { return m_formantShift; }

private:
    // sample rate
    t_CKFLOAT m_srate;

    // FFT params
    int m_fftSize;
    int m_overlapFactor;
    int m_hopSize;
    int m_complexSize;

    // parameters
    t_CKFLOAT m_pitchShift;
    t_CKFLOAT m_gain;
    bool m_loop;
    bool m_playing;

    // spectral effects
    bool m_freeze;
    bool m_robotize;
    bool m_whisperize;
    t_CKFLOAT m_spectralBlur;
    t_CKFLOAT m_spectralGate;
    t_CKFLOAT m_formantShift;

    // buffers
    std::vector<float> m_inputBuf;
    std::vector<float> m_outputBuf;
    std::vector<float> m_window;
    t_CKINT m_readPos;
    t_CKINT m_crossfadeLen;
    bool m_dirty;

    // FFT engine
    audiofft::AudioFFT m_fft;

    //--- update derived params ---
    void updateParams()
    {
        m_hopSize = m_fftSize / m_overlapFactor;
        m_complexSize = (int)audiofft::AudioFFT::ComplexSize( m_fftSize );

        // precompute Hann window
        m_window.resize( m_fftSize );
        for( int i = 0; i < m_fftSize; i++ )
        {
            m_window[i] = 0.5f * (1.0f - cosf( 2.0f * (float)M_PI * i / (float)m_fftSize ));
        }

        // init FFT
        m_fft.init( m_fftSize );
    }

    //--- core resynthesis ---
    void resynthesize()
    {
        if( m_inputBuf.empty() )
        {
            m_outputBuf.clear();
            m_dirty = false;
            return;
        }

        int inputLen = (int)m_inputBuf.size();

        // number of analysis frames
        int numFrames = (inputLen - m_fftSize) / m_hopSize + 1;
        if( numFrames < 1 ) numFrames = 1;

        // pad input if needed
        int paddedLen = (numFrames - 1) * m_hopSize + m_fftSize;
        std::vector<float> padded( paddedLen, 0.0f );
        memcpy( padded.data(), m_inputBuf.data(),
                std::min( inputLen, paddedLen ) * sizeof(float) );

        // analysis: extract magnitude and phase for each frame
        std::vector< std::vector<float> > frameMags( numFrames );
        std::vector< std::vector<float> > framePhases( numFrames );

        std::vector<float> frameBuf( m_fftSize );
        std::vector<float> re( m_complexSize );
        std::vector<float> im( m_complexSize );

        for( int f = 0; f < numFrames; f++ )
        {
            int offset = f * m_hopSize;

            // window the frame
            for( int i = 0; i < m_fftSize; i++ )
                frameBuf[i] = padded[offset + i] * m_window[i];

            // FFT
            m_fft.fft( frameBuf.data(), re.data(), im.data() );

            // convert to magnitude/phase
            frameMags[f].resize( m_complexSize );
            framePhases[f].resize( m_complexSize );

            for( int k = 0; k < m_complexSize; k++ )
            {
                frameMags[f][k] = sqrtf( re[k] * re[k] + im[k] * im[k] );
                framePhases[f][k] = atan2f( im[k], re[k] );
            }
        }

        // --- apply spectral effects to each frame ---
        double pitchRatio = pow( 2.0, m_pitchShift / 12.0 );
        double formantRatio = pow( 2.0, m_formantShift / 12.0 );

        // phase accumulator for pitch shifting
        std::vector<float> phaseAccum( m_complexSize, 0.0f );
        std::vector<float> prevPhase( m_complexSize, 0.0f );

        // expected phase advance per hop for each bin
        float freqPerBin = (float)m_srate / (float)m_fftSize;
        float expectedPhaseAdv = 2.0f * (float)M_PI * (float)m_hopSize / (float)m_fftSize;

        // output accumulator
        int outputLen = paddedLen;
        m_outputBuf.assign( outputLen, 0.0f );

        // normalization buffer for overlap-add
        std::vector<float> normBuf( outputLen, 0.0f );

        std::vector<float> shiftedMag( m_complexSize );
        std::vector<float> shiftedPhase( m_complexSize );

        int freezeFrame = numFrames / 2; // freeze at midpoint

        for( int f = 0; f < numFrames; f++ )
        {
            int srcFrame = f;
            if( m_freeze ) srcFrame = freezeFrame;

            std::vector<float> & mag = frameMags[srcFrame];
            std::vector<float> & phase = framePhases[srcFrame];

            // --- spectral gate: zero bins below threshold ---
            if( m_spectralGate > 0.0 )
            {
                float maxMag = 0.0f;
                for( int k = 0; k < m_complexSize; k++ )
                    if( mag[k] > maxMag ) maxMag = mag[k];

                float threshold = maxMag * (float)m_spectralGate;
                for( int k = 0; k < m_complexSize; k++ )
                    if( mag[k] < threshold ) mag[k] = 0.0f;
            }

            // --- spectral blur: smooth magnitudes ---
            if( m_spectralBlur > 0.0 )
            {
                int radius = (int)( m_spectralBlur * 10.0 );
                if( radius < 1 ) radius = 1;
                if( radius > m_complexSize / 2 ) radius = m_complexSize / 2;

                std::vector<float> smoothed( m_complexSize );
                for( int k = 0; k < m_complexSize; k++ )
                {
                    float sum = 0.0f;
                    int count = 0;
                    for( int j = k - radius; j <= k + radius; j++ )
                    {
                        if( j >= 0 && j < m_complexSize )
                        {
                            sum += mag[j];
                            count++;
                        }
                    }
                    smoothed[k] = sum / (float)count;
                }
                mag = smoothed;
            }

            // --- pitch shifting: remap bins ---
            memset( shiftedMag.data(), 0, m_complexSize * sizeof(float) );
            memset( shiftedPhase.data(), 0, m_complexSize * sizeof(float) );

            if( fabs( pitchRatio - 1.0 ) < 0.001 && fabs( formantRatio - 1.0 ) < 0.001 )
            {
                // no shift — copy directly
                memcpy( shiftedMag.data(), mag.data(), m_complexSize * sizeof(float) );

                // phase propagation (identity)
                for( int k = 0; k < m_complexSize; k++ )
                {
                    float phaseDiff = phase[k] - prevPhase[k];
                    float expected = (float)k * expectedPhaseAdv;
                    float deviation = phaseDiff - expected;

                    // wrap to [-pi, pi]
                    deviation = fmodf( deviation + (float)M_PI, 2.0f * (float)M_PI );
                    if( deviation < 0 ) deviation += 2.0f * (float)M_PI;
                    deviation -= (float)M_PI;

                    float trueFreq = (float)k * expectedPhaseAdv + deviation;
                    phaseAccum[k] += trueFreq;
                    shiftedPhase[k] = phaseAccum[k];
                }
            }
            else
            {
                // pitch shift with optional formant preservation
                for( int k = 0; k < m_complexSize; k++ )
                {
                    // source bin for this output bin
                    double srcBin = (double)k / pitchRatio;
                    int srcBinInt = (int)srcBin;
                    float frac = (float)( srcBin - srcBinInt );

                    // magnitude: interpolate from source bins
                    float interpMag = 0.0f;
                    if( srcBinInt >= 0 && srcBinInt < m_complexSize - 1 )
                        interpMag = mag[srcBinInt] * (1.0f - frac) + mag[srcBinInt + 1] * frac;
                    else if( srcBinInt == m_complexSize - 1 )
                        interpMag = mag[srcBinInt];

                    // formant shift: scale the magnitude envelope
                    if( fabs( formantRatio - 1.0 ) > 0.001 )
                    {
                        double envBin = (double)k / formantRatio;
                        int envBinInt = (int)envBin;
                        float envFrac = (float)( envBin - envBinInt );

                        float envMag = 0.0f;
                        if( envBinInt >= 0 && envBinInt < m_complexSize - 1 )
                            envMag = mag[envBinInt] * (1.0f - envFrac) + mag[envBinInt + 1] * envFrac;
                        else if( envBinInt == m_complexSize - 1 )
                            envMag = mag[envBinInt];

                        // preserve formant: use original envelope ratio
                        if( interpMag > 1e-10f )
                            interpMag = envMag;
                    }

                    shiftedMag[k] = interpMag;

                    // phase: accumulate with shifted frequency
                    if( srcBinInt >= 0 && srcBinInt < m_complexSize )
                    {
                        float phaseDiff = phase[srcBinInt] - prevPhase[srcBinInt];
                        float expected = (float)srcBinInt * expectedPhaseAdv;
                        float deviation = phaseDiff - expected;

                        deviation = fmodf( deviation + (float)M_PI, 2.0f * (float)M_PI );
                        if( deviation < 0 ) deviation += 2.0f * (float)M_PI;
                        deviation -= (float)M_PI;

                        float trueFreq = (float)srcBinInt * expectedPhaseAdv + deviation;
                        float shiftedFreq = trueFreq * (float)pitchRatio;

                        phaseAccum[k] += shiftedFreq;
                        shiftedPhase[k] = phaseAccum[k];
                    }
                }
            }

            // --- robotize: zero all phases ---
            if( m_robotize )
            {
                for( int k = 0; k < m_complexSize; k++ )
                    shiftedPhase[k] = 0.0f;
            }

            // --- whisperize: randomize phases ---
            if( m_whisperize )
            {
                for( int k = 0; k < m_complexSize; k++ )
                    shiftedPhase[k] = ((float)rand() / (float)RAND_MAX) * 2.0f * (float)M_PI - (float)M_PI;
            }

            // save phase for next frame
            memcpy( prevPhase.data(), phase.data(), m_complexSize * sizeof(float) );

            // convert back to real/imag
            for( int k = 0; k < m_complexSize; k++ )
            {
                re[k] = shiftedMag[k] * cosf( shiftedPhase[k] );
                im[k] = shiftedMag[k] * sinf( shiftedPhase[k] );
            }

            // IFFT
            m_fft.ifft( frameBuf.data(), re.data(), im.data() );

            // window and overlap-add
            int offset = f * m_hopSize;
            for( int i = 0; i < m_fftSize; i++ )
            {
                if( offset + i < outputLen )
                {
                    m_outputBuf[offset + i] += frameBuf[i] * m_window[i];
                    normBuf[offset + i] += m_window[i] * m_window[i];
                }
            }
        }

        // normalize by overlap-add window sum
        for( int i = 0; i < outputLen; i++ )
        {
            if( normBuf[i] > 1e-6f )
                m_outputBuf[i] /= normBuf[i];
        }

        m_dirty = false;
    }
};


//-----------------------------------------------------------------------------
// info
//-----------------------------------------------------------------------------
CK_DLL_INFO( SpectralSynth )
{
    QUERY->setinfo( QUERY, CHUGIN_INFO_CHUGIN_VERSION, "1.0.0" );
    QUERY->setinfo( QUERY, CHUGIN_INFO_AUTHORS, "" );
    QUERY->setinfo( QUERY, CHUGIN_INFO_DESCRIPTION,
        "FFT-based spectral resynthesis with pitch shifting and spectral effects" );
}


//-----------------------------------------------------------------------------
// query
//-----------------------------------------------------------------------------
CK_DLL_QUERY( SpectralSynth )
{
    QUERY->setname( QUERY, "SpectralSynth" );
    QUERY->begin_class( QUERY, "SpectralSynth", "UGen" );

    // ctor / dtor / tick
    QUERY->add_ctor( QUERY, spectralsynth_ctor );
    QUERY->add_dtor( QUERY, spectralsynth_dtor );
    QUERY->add_ugen_func( QUERY, spectralsynth_tick, NULL, 1, 1 );

    // --- input ---
    QUERY->add_mfun( QUERY, spectralsynth_input, "void", "input" );
    QUERY->add_arg( QUERY, "float[]", "audio" );

    // --- transport ---
    QUERY->add_mfun( QUERY, spectralsynth_play, "void", "play" );
    QUERY->add_mfun( QUERY, spectralsynth_stop, "void", "stop" );

    // --- pitchShift ---
    QUERY->add_mfun( QUERY, spectralsynth_setPitchShift, "float", "pitchShift" );
    QUERY->add_arg( QUERY, "float", "semitones" );
    QUERY->add_mfun( QUERY, spectralsynth_getPitchShift, "float", "pitchShift" );

    // --- fftSize ---
    QUERY->add_mfun( QUERY, spectralsynth_setFftSize, "int", "fftSize" );
    QUERY->add_arg( QUERY, "int", "size" );
    QUERY->add_mfun( QUERY, spectralsynth_getFftSize, "int", "fftSize" );

    // --- overlap ---
    QUERY->add_mfun( QUERY, spectralsynth_setOverlap, "int", "overlap" );
    QUERY->add_arg( QUERY, "int", "factor" );
    QUERY->add_mfun( QUERY, spectralsynth_getOverlap, "int", "overlap" );

    // --- loop ---
    QUERY->add_mfun( QUERY, spectralsynth_setLoop, "int", "loop" );
    QUERY->add_arg( QUERY, "int", "val" );
    QUERY->add_mfun( QUERY, spectralsynth_getLoop, "int", "loop" );

    // --- pos ---
    QUERY->add_mfun( QUERY, spectralsynth_setPos, "int", "pos" );
    QUERY->add_arg( QUERY, "int", "sample" );
    QUERY->add_mfun( QUERY, spectralsynth_getPos, "int", "pos" );

    // --- gain ---
    QUERY->add_mfun( QUERY, spectralsynth_setGain, "float", "gain" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, spectralsynth_getGain, "float", "gain" );

    // --- crossfade ---
    QUERY->add_mfun( QUERY, spectralsynth_setCrossfade, "int", "crossfade" );
    QUERY->add_arg( QUERY, "int", "samples" );
    QUERY->add_mfun( QUERY, spectralsynth_getCrossfade, "int", "crossfade" );

    // --- freeze ---
    QUERY->add_mfun( QUERY, spectralsynth_setFreeze, "int", "freeze" );
    QUERY->add_arg( QUERY, "int", "val" );
    QUERY->add_mfun( QUERY, spectralsynth_getFreeze, "int", "freeze" );

    // --- robotize ---
    QUERY->add_mfun( QUERY, spectralsynth_setRobotize, "int", "robotize" );
    QUERY->add_arg( QUERY, "int", "val" );
    QUERY->add_mfun( QUERY, spectralsynth_getRobotize, "int", "robotize" );

    // --- whisperize ---
    QUERY->add_mfun( QUERY, spectralsynth_setWhisperize, "int", "whisperize" );
    QUERY->add_arg( QUERY, "int", "val" );
    QUERY->add_mfun( QUERY, spectralsynth_getWhisperize, "int", "whisperize" );

    // --- spectralBlur ---
    QUERY->add_mfun( QUERY, spectralsynth_setSpectralBlur, "float", "spectralBlur" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, spectralsynth_getSpectralBlur, "float", "spectralBlur" );

    // --- spectralGate ---
    QUERY->add_mfun( QUERY, spectralsynth_setSpectralGate, "float", "spectralGate" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, spectralsynth_getSpectralGate, "float", "spectralGate" );

    // --- formantShift ---
    QUERY->add_mfun( QUERY, spectralsynth_setFormantShift, "float", "formantShift" );
    QUERY->add_arg( QUERY, "float", "semitones" );
    QUERY->add_mfun( QUERY, spectralsynth_getFormantShift, "float", "formantShift" );

    // internal data offset
    spectralsynth_data_offset = QUERY->add_mvar( QUERY, "int", "@ss_data", false );

    QUERY->end_class( QUERY );
    return TRUE;
}


//-----------------------------------------------------------------------------
// ctor
//-----------------------------------------------------------------------------
CK_DLL_CTOR( spectralsynth_ctor )
{
    OBJ_MEMBER_INT( SELF, spectralsynth_data_offset ) = 0;
    SpectralSynth * obj = new SpectralSynth( API->vm->srate(VM) );
    OBJ_MEMBER_INT( SELF, spectralsynth_data_offset ) = (t_CKINT)obj;
}


//-----------------------------------------------------------------------------
// dtor
//-----------------------------------------------------------------------------
CK_DLL_DTOR( spectralsynth_dtor )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    CK_SAFE_DELETE( obj );
    OBJ_MEMBER_INT( SELF, spectralsynth_data_offset ) = 0;
}


//-----------------------------------------------------------------------------
// tick
//-----------------------------------------------------------------------------
CK_DLL_TICK( spectralsynth_tick )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    if( obj ) *out = obj->tick( in );
    return TRUE;
}


//-----------------------------------------------------------------------------
// input
//-----------------------------------------------------------------------------
CK_DLL_MFUN( spectralsynth_input )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    Chuck_ArrayFloat * arr = (Chuck_ArrayFloat *)GET_NEXT_OBJECT( ARGS );

    if( !arr || !obj ) return;

    t_CKINT len = API->object->array_float_size( arr );
    std::vector<float> audio( len );
    for( t_CKINT i = 0; i < len; i++ )
        audio[i] = (float)API->object->array_float_get_idx( arr, i );

    obj->setInput( audio );
}


//-----------------------------------------------------------------------------
// transport
//-----------------------------------------------------------------------------
CK_DLL_MFUN( spectralsynth_play )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    if( obj ) obj->play();
}

CK_DLL_MFUN( spectralsynth_stop )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    if( obj ) obj->stop();
}


//-----------------------------------------------------------------------------
// parameter setters/getters
//-----------------------------------------------------------------------------
CK_DLL_MFUN( spectralsynth_setPitchShift )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->setPitchShift( GET_NEXT_FLOAT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getPitchShift )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->getPitchShift();
}

CK_DLL_MFUN( spectralsynth_setFftSize )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->setFftSize( GET_NEXT_INT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getFftSize )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->getFftSize();
}

CK_DLL_MFUN( spectralsynth_setOverlap )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->setOverlap( GET_NEXT_INT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getOverlap )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->getOverlap();
}

CK_DLL_MFUN( spectralsynth_setLoop )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->setLoop( GET_NEXT_INT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getLoop )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->getLoop();
}

CK_DLL_MFUN( spectralsynth_setPos )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->setPos( GET_NEXT_INT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getPos )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->getPos();
}

CK_DLL_MFUN( spectralsynth_setGain )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->setGain( GET_NEXT_FLOAT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getGain )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->getGain();
}

CK_DLL_MFUN( spectralsynth_setCrossfade )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->setCrossfade( GET_NEXT_INT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getCrossfade )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->getCrossfade();
}


//-----------------------------------------------------------------------------
// spectral effects setters/getters
//-----------------------------------------------------------------------------
CK_DLL_MFUN( spectralsynth_setFreeze )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->setFreeze( GET_NEXT_INT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getFreeze )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->getFreeze();
}

CK_DLL_MFUN( spectralsynth_setRobotize )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->setRobotize( GET_NEXT_INT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getRobotize )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->getRobotize();
}

CK_DLL_MFUN( spectralsynth_setWhisperize )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->setWhisperize( GET_NEXT_INT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getWhisperize )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->getWhisperize();
}

CK_DLL_MFUN( spectralsynth_setSpectralBlur )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->setSpectralBlur( GET_NEXT_FLOAT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getSpectralBlur )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->getSpectralBlur();
}

CK_DLL_MFUN( spectralsynth_setSpectralGate )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->setSpectralGate( GET_NEXT_FLOAT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getSpectralGate )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->getSpectralGate();
}

CK_DLL_MFUN( spectralsynth_setFormantShift )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->setFormantShift( GET_NEXT_FLOAT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getFormantShift )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->getFormantShift();
}
