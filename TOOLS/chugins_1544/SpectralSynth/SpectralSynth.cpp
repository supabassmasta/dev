//-----------------------------------------------------------------------------
// SpectralSynth — FFT-based spectral resynthesis chugin for ChucK
// Phase vocoder with pitch shifting and spectral effects
//-----------------------------------------------------------------------------

#include "chugin.h"
#include "AudioFFT.h"

#include <cmath>
#include <cstring>
#include <cstdlib>
#include <cstdio>
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

// chunked file loading
CK_DLL_MFUN( spectralsynth_open );
CK_DLL_MFUN( spectralsynth_loadSamples );
CK_DLL_MFUN( spectralsynth_loaded );
CK_DLL_MFUN( spectralsynth_numSamples );

// transport
CK_DLL_MFUN( spectralsynth_play );
CK_DLL_MFUN( spectralsynth_stop );

// incremental processing
CK_DLL_MFUN( spectralsynth_prepare );
CK_DLL_MFUN( spectralsynth_analyzeFrames );
CK_DLL_MFUN( spectralsynth_analyzed );
CK_DLL_MFUN( spectralsynth_processFrames );
CK_DLL_MFUN( spectralsynth_ready );
CK_DLL_MFUN( spectralsynth_numFrames );

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
CK_DLL_MFUN( spectralsynth_setLoopStart );
CK_DLL_MFUN( spectralsynth_getLoopStart );
CK_DLL_MFUN( spectralsynth_setLoopEnd );
CK_DLL_MFUN( spectralsynth_getLoopEnd );

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
CK_DLL_MFUN( spectralsynth_setPhaseMode );
CK_DLL_MFUN( spectralsynth_getPhaseMode );

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
    , m_phaseMode( true )
    , m_readPos( 0 )
    , m_crossfadeLen( 1024 )
    , m_loopStart( 0.0 )
    , m_loopEnd( 1.0 )
    , m_dirty( false )
    , m_numFrames( 0 )
    , m_analyzedFrames( 0 )
    , m_analyzed( false )
    , m_processedFrames( 0 )
    , m_ready( false )
    , m_file( NULL )
    , m_fileChannels( 0 )
    , m_fileBytesPerSample( 0 )
    , m_fileBlockAlign( 0 )
    , m_fileAudioFormat( 0 )
    , m_fileTotalSamples( 0 )
    , m_fileLoadedSamples( 0 )
    , m_fileLoaded( false )
    {
        updateParams();
    }

    ~SpectralSynth()
    {
        if( m_file ) { fclose( m_file ); m_file = NULL; }
    }

    //--- input ---
    void setInput( const std::vector<float> & audio )
    {
        m_inputBuf = audio;
        m_dirty = true;
        m_ready = false;
        m_analyzed = false;
        resynthesize();
    }

    //--- chunked file loading ---
    t_CKINT openFile( const char * path )
    {
        // close any previously open file
        if( m_file ) { fclose( m_file ); m_file = NULL; }
        m_fileLoaded = false;
        m_fileLoadedSamples = 0;
        m_fileTotalSamples = 0;

        m_file = fopen( path, "rb" );
        if( !m_file ) return 0;

        // read RIFF header
        char riff[4];
        if( fread( riff, 1, 4, m_file ) != 4 ||
            riff[0] != 'R' || riff[1] != 'I' || riff[2] != 'F' || riff[3] != 'F' )
        { fclose( m_file ); m_file = NULL; return 0; }

        uint32_t fileSize;
        fread( &fileSize, 4, 1, m_file );

        char wave[4];
        if( fread( wave, 1, 4, m_file ) != 4 ||
            wave[0] != 'W' || wave[1] != 'A' || wave[2] != 'V' || wave[3] != 'E' )
        { fclose( m_file ); m_file = NULL; return 0; }

        // find fmt and data chunks
        int16_t numChannels = 0, bitsPerSample = 0;
        int16_t audioFormat = 0;
        int16_t blockAlign = 0;
        uint32_t dataSize = 0;
        bool foundFmt = false, foundData = false;

        while( !foundData && !feof( m_file ) )
        {
            char chunkId[4];
            uint32_t chunkSize;
            if( fread( chunkId, 1, 4, m_file ) != 4 ) break;
            if( fread( &chunkSize, 4, 1, m_file ) != 1 ) break;

            if( chunkId[0] == 'f' && chunkId[1] == 'm' &&
                chunkId[2] == 't' && chunkId[3] == ' ' )
            {
                fread( &audioFormat, 2, 1, m_file );
                fread( &numChannels, 2, 1, m_file );
                int32_t sampleRate;
                fread( &sampleRate, 4, 1, m_file );
                int32_t byteRate;
                fread( &byteRate, 4, 1, m_file );
                fread( &blockAlign, 2, 1, m_file );
                fread( &bitsPerSample, 2, 1, m_file );
                long remaining = (long)chunkSize - 16;
                if( remaining > 0 ) fseek( m_file, remaining, SEEK_CUR );
                foundFmt = true;
            }
            else if( chunkId[0] == 'd' && chunkId[1] == 'a' &&
                     chunkId[2] == 't' && chunkId[3] == 'a' )
            {
                dataSize = chunkSize;
                foundData = true;
                // file position is now at the start of audio data
            }
            else
            {
                fseek( m_file, chunkSize, SEEK_CUR );
            }
        }

        if( !foundFmt || !foundData || numChannels < 1 )
        { fclose( m_file ); m_file = NULL; return 0; }

        // validate format: PCM (1) or IEEE float (3)
        if( audioFormat != 1 && audioFormat != 3 )
        { fclose( m_file ); m_file = NULL; return 0; }

        // validate bit depth
        if( audioFormat == 1 && bitsPerSample != 8 && bitsPerSample != 16 &&
            bitsPerSample != 24 && bitsPerSample != 32 )
        { fclose( m_file ); m_file = NULL; return 0; }
        if( audioFormat == 3 && bitsPerSample != 32 )
        { fclose( m_file ); m_file = NULL; return 0; }

        m_fileAudioFormat = audioFormat;
        m_fileChannels = numChannels;
        m_fileBytesPerSample = bitsPerSample / 8;
        m_fileBlockAlign = blockAlign;

        // total mono samples
        int totalInterleavedSamples = dataSize / (m_fileBytesPerSample * m_fileChannels);
        m_fileTotalSamples = totalInterleavedSamples;

        // prepare input buffer
        m_inputBuf.clear();
        m_inputBuf.reserve( m_fileTotalSamples );
        m_fileLoadedSamples = 0;
        m_fileLoaded = false;

        // reset output state
        m_dirty = true;
        m_ready = false;
        m_analyzed = false;

        return (t_CKINT)m_fileTotalSamples;
    }

    t_CKINT loadSamples( int n )
    {
        if( !m_file || m_fileLoaded ) return 0;

        int remaining = m_fileTotalSamples - m_fileLoadedSamples;
        if( n > remaining ) n = remaining;
        if( n <= 0 ) return 0;

        // read interleaved frames from disk
        int frameBytes = m_fileBlockAlign;  // bytes per interleaved frame
        int bytesPerChan = m_fileBytesPerSample;

        // read buffer: n interleaved frames
        std::vector<uint8_t> rawBuf( n * frameBytes );
        int framesRead = (int)fread( rawBuf.data(), frameBytes, n, m_file );
        if( framesRead <= 0 )
        {
            // premature end of file — mark as loaded
            fclose( m_file ); m_file = NULL;
            m_fileLoaded = true;
            return 0;
        }

        // extract first channel, convert to float
        for( int i = 0; i < framesRead; i++ )
        {
            const uint8_t * frame = rawBuf.data() + i * frameBytes;
            float sample = 0.0f;

            if( m_fileAudioFormat == 3 ) // IEEE float 32-bit
            {
                float v;
                memcpy( &v, frame, 4 );
                sample = v;
            }
            else // PCM
            {
                switch( bytesPerChan )
                {
                case 1: // 8-bit unsigned
                    sample = ((float)frame[0] - 128.0f) / 128.0f;
                    break;
                case 2: // 16-bit signed
                {
                    int16_t v;
                    memcpy( &v, frame, 2 );
                    sample = (float)v / 32768.0f;
                    break;
                }
                case 3: // 24-bit signed
                {
                    int32_t v = (int32_t)frame[0] | ((int32_t)frame[1] << 8) | ((int32_t)frame[2] << 16);
                    if( v & 0x800000 ) v |= 0xFF000000; // sign extend
                    sample = (float)v / 8388608.0f;
                    break;
                }
                case 4: // 32-bit signed
                {
                    int32_t v;
                    memcpy( &v, frame, 4 );
                    sample = (float)((double)v / 2147483648.0);
                    break;
                }
                }
            }

            m_inputBuf.push_back( sample );
        }

        m_fileLoadedSamples += framesRead;

        if( m_fileLoadedSamples >= m_fileTotalSamples )
        {
            fclose( m_file ); m_file = NULL;
            m_fileLoaded = true;
        }

        return m_fileTotalSamples - m_fileLoadedSamples;
    }

    t_CKINT loaded() { return m_fileLoaded ? 1 : 0; }
    t_CKINT getNumSamples() { return (t_CKINT)m_fileTotalSamples; }

    //--- transport ---
    void play()
    {
        if( m_dirty && !m_ready ) resynthesize();
        m_readPos = 0;
        m_playing = true;
    }

    void stop()
    {
        m_playing = false;
    }

    //--- incremental processing ---
    void prepare()
    {
        if( m_inputBuf.empty() )
        {
            m_outputBuf.clear();
            m_dirty = false;
            m_ready = false;
            m_analyzed = false;
            m_numFrames = 0;
            m_analyzedFrames = 0;
            m_processedFrames = 0;
            return;
        }

        int inputLen = (int)m_inputBuf.size();

        // number of analysis frames
        m_numFrames = (inputLen - m_fftSize) / m_hopSize + 1;
        if( m_numFrames < 1 ) m_numFrames = 1;

        // pad input if needed
        int paddedLen = (m_numFrames - 1) * m_hopSize + m_fftSize;
        m_padded.assign( paddedLen, 0.0f );
        memcpy( m_padded.data(), m_inputBuf.data(),
                std::min( inputLen, paddedLen ) * sizeof(float) );

        // allocate analysis arrays
        m_frameMags.resize( m_numFrames );
        m_framePhases.resize( m_numFrames );

        // allocate output and normalization buffers
        int outputLen = paddedLen;
        m_outputBuf.assign( outputLen, 0.0f );
        m_normBuf.assign( outputLen, 0.0f );

        // reset phase accumulators
        m_phaseAccum.assign( m_complexSize, 0.0f );
        m_prevPhase.assign( m_complexSize, 0.0f );

        // reset cursors
        m_analyzedFrames = 0;
        m_analyzed = false;
        m_processedFrames = 0;
        m_ready = false;
    }

    t_CKINT analyzeFrames( int n )
    {
        if( m_numFrames == 0 ) return 0;

        int endFrame = m_analyzedFrames + n;
        if( endFrame > m_numFrames ) endFrame = m_numFrames;

        std::vector<float> frameBuf( m_fftSize );
        std::vector<float> re( m_complexSize );
        std::vector<float> im( m_complexSize );

        for( int f = m_analyzedFrames; f < endFrame; f++ )
        {
            int offset = f * m_hopSize;

            // window the frame
            for( int i = 0; i < m_fftSize; i++ )
                frameBuf[i] = m_padded[offset + i] * m_window[i];

            // FFT
            m_fft.fft( frameBuf.data(), re.data(), im.data() );

            // convert to magnitude/phase
            m_frameMags[f].resize( m_complexSize );
            m_framePhases[f].resize( m_complexSize );

            for( int k = 0; k < m_complexSize; k++ )
            {
                m_frameMags[f][k] = sqrtf( re[k] * re[k] + im[k] * im[k] );
                m_framePhases[f][k] = atan2f( im[k], re[k] );
            }
        }

        m_analyzedFrames = endFrame;

        if( m_analyzedFrames >= m_numFrames )
            m_analyzed = true;

        return m_numFrames - m_analyzedFrames;
    }

    t_CKINT analyzed() { return m_analyzed ? 1 : 0; }

    t_CKINT processFrames( int n )
    {
        if( m_numFrames == 0 ) return 0;

        int endFrame = m_processedFrames + n;
        if( endFrame > m_numFrames ) endFrame = m_numFrames;

        double pitchRatio = pow( 2.0, m_pitchShift / 12.0 );
        float expectedPhaseAdv = 2.0f * (float)M_PI * (float)m_hopSize / (float)m_fftSize;
        int outputLen = (int)m_outputBuf.size();
        int freezeFrame = m_numFrames / 2;

        std::vector<float> shiftedMag( m_complexSize );
        std::vector<float> shiftedPhase( m_complexSize );
        std::vector<float> frameBuf( m_fftSize );
        std::vector<float> re( m_complexSize );
        std::vector<float> im( m_complexSize );

        for( int f = m_processedFrames; f < endFrame; f++ )
        {
            int srcFrame = f;
            if( m_freeze ) srcFrame = freezeFrame;

            std::vector<float> & mag = m_frameMags[srcFrame];
            std::vector<float> & phase = m_framePhases[srcFrame];

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

            if( fabs( pitchRatio - 1.0 ) < 0.001 )
            {
                // no shift — copy directly
                memcpy( shiftedMag.data(), mag.data(), m_complexSize * sizeof(float) );

                if( m_phaseMode )
                {
                    // phase propagation (identity)
                    for( int k = 0; k < m_complexSize; k++ )
                    {
                        float phaseDiff = phase[k] - m_prevPhase[k];
                        float expected = (float)k * expectedPhaseAdv;
                        float deviation = phaseDiff - expected;

                        // wrap to [-pi, pi]
                        deviation = fmodf( deviation + (float)M_PI, 2.0f * (float)M_PI );
                        if( deviation < 0 ) deviation += 2.0f * (float)M_PI;
                        deviation -= (float)M_PI;

                        float trueFreq = (float)k * expectedPhaseAdv + deviation;
                        m_phaseAccum[k] += trueFreq;
                        shiftedPhase[k] = m_phaseAccum[k];
                    }
                }
                else
                {
                    // raw analysis phases
                    memcpy( shiftedPhase.data(), phase.data(), m_complexSize * sizeof(float) );
                }
            }
            else
            {
                // pitch shift
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

                    shiftedMag[k] = interpMag;

                    // phase
                    if( srcBinInt >= 0 && srcBinInt < m_complexSize )
                    {
                        if( m_phaseMode )
                        {
                            // phase vocoder: accumulate with shifted frequency
                            float phaseDiff = phase[srcBinInt] - m_prevPhase[srcBinInt];
                            float expected = (float)srcBinInt * expectedPhaseAdv;
                            float deviation = phaseDiff - expected;

                            deviation = fmodf( deviation + (float)M_PI, 2.0f * (float)M_PI );
                            if( deviation < 0 ) deviation += 2.0f * (float)M_PI;
                            deviation -= (float)M_PI;

                            float trueFreq = (float)srcBinInt * expectedPhaseAdv + deviation;
                            float shiftedFreq = trueFreq * (float)pitchRatio;

                            m_phaseAccum[k] += shiftedFreq;
                            shiftedPhase[k] = m_phaseAccum[k];
                        }
                        else
                        {
                            // raw: use source bin's analysis phase directly
                            shiftedPhase[k] = phase[srcBinInt];
                        }
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
            memcpy( m_prevPhase.data(), phase.data(), m_complexSize * sizeof(float) );

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
                    m_normBuf[offset + i] += m_window[i] * m_window[i];
                }
            }
        }

        m_processedFrames = endFrame;

        // if all frames processed, run normalization
        if( m_processedFrames >= m_numFrames )
        {
            for( int i = 0; i < outputLen; i++ )
            {
                if( m_normBuf[i] > 1e-6f )
                    m_outputBuf[i] /= m_normBuf[i];
            }
            m_dirty = false;
            m_ready = true;
        }

        return m_numFrames - m_processedFrames;
    }

    t_CKINT ready() { return m_ready ? 1 : 0; }
    t_CKINT getNumFrames() { return m_numFrames; }

    //--- tick ---
    SAMPLE tick( SAMPLE in )
    {
        if( !m_playing || m_outputBuf.empty() )
            return 0.0;

        t_CKINT bufLen = (t_CKINT)m_outputBuf.size();
        SAMPLE out = (SAMPLE)m_outputBuf[m_readPos];

        if( m_loop )
        {
            // compute loop region in samples
            t_CKINT loopStartSamp = (t_CKINT)( m_loopStart * bufLen );
            t_CKINT loopEndSamp = (t_CKINT)( m_loopEnd * bufLen );
            if( loopStartSamp < 0 ) loopStartSamp = 0;
            if( loopEndSamp > bufLen ) loopEndSamp = bufLen;
            t_CKINT loopLen = loopEndSamp - loopStartSamp;

            // crossfade at end of loop region
            if( m_crossfadeLen > 0 && loopLen > m_crossfadeLen )
            {
                t_CKINT fadeStart = loopEndSamp - m_crossfadeLen;

                if( m_readPos >= fadeStart && m_readPos < loopEndSamp )
                {
                    float fadePos = (float)(m_readPos - fadeStart) / (float)m_crossfadeLen;
                    float fadeOut = cosf( fadePos * 0.5f * (float)M_PI );
                    float fadeIn  = sinf( fadePos * 0.5f * (float)M_PI );
                    // blend with corresponding position at the start of loop
                    t_CKINT headPos = loopStartSamp + (m_readPos - fadeStart);
                    if( headPos < loopEndSamp )
                        out = out * fadeOut + m_outputBuf[headPos] * fadeIn;
                }
            }

            out *= (SAMPLE)m_gain;
            m_readPos++;

            // wrap at loop end
            if( m_readPos >= loopEndSamp )
            {
                t_CKINT fadeLen = m_crossfadeLen;
                if( fadeLen > loopLen ) fadeLen = loopLen;
                m_readPos = loopStartSamp + fadeLen;
            }
        }
        else
        {
            out *= (SAMPLE)m_gain;
            m_readPos++;

            if( m_readPos >= bufLen )
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

    t_CKFLOAT setLoopStart( t_CKFLOAT v )
    {
        m_loopStart = std::max( 0.0, std::min( 1.0, v ) );
        if( m_loopStart >= m_loopEnd ) m_loopStart = m_loopEnd;
        return m_loopStart;
    }
    t_CKFLOAT getLoopStart() { return m_loopStart; }

    t_CKFLOAT setLoopEnd( t_CKFLOAT v )
    {
        m_loopEnd = std::max( 0.0, std::min( 1.0, v ) );
        if( m_loopEnd <= m_loopStart ) m_loopEnd = m_loopStart;
        return m_loopEnd;
    }
    t_CKFLOAT getLoopEnd() { return m_loopEnd; }

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

    t_CKINT setPhaseMode( t_CKINT v )
    {
        m_phaseMode = (v != 0);
        m_dirty = true;
        return m_phaseMode ? 1 : 0;
    }
    t_CKINT getPhaseMode() { return m_phaseMode ? 1 : 0; }

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
    bool m_phaseMode;

    // buffers
    std::vector<float> m_inputBuf;
    std::vector<float> m_outputBuf;
    std::vector<float> m_window;
    t_CKINT m_readPos;
    t_CKINT m_crossfadeLen;
    t_CKFLOAT m_loopStart;
    t_CKFLOAT m_loopEnd;
    bool m_dirty;

    // FFT engine
    audiofft::AudioFFT m_fft;

    // incremental processing state
    std::vector< std::vector<float> > m_frameMags;
    std::vector< std::vector<float> > m_framePhases;
    std::vector<float> m_padded;
    std::vector<float> m_normBuf;
    std::vector<float> m_phaseAccum;
    std::vector<float> m_prevPhase;
    int m_numFrames;
    int m_analyzedFrames;
    bool m_analyzed;
    int m_processedFrames;
    bool m_ready;

    // chunked file loading state
    FILE * m_file;
    int m_fileChannels;
    int m_fileBytesPerSample;
    int m_fileBlockAlign;
    int m_fileAudioFormat;   // 1=PCM, 3=IEEE float
    int m_fileTotalSamples;  // mono sample count
    int m_fileLoadedSamples;
    bool m_fileLoaded;

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

    //--- core resynthesis (convenience: runs prepare + processFrames all at once) ---
    void resynthesize()
    {
        prepare();
        analyzeFrames( m_numFrames );
        processFrames( m_numFrames );
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

    // --- chunked file loading ---
    QUERY->add_mfun( QUERY, spectralsynth_open, "int", "open" );
    QUERY->add_arg( QUERY, "string", "path" );
    QUERY->add_mfun( QUERY, spectralsynth_loadSamples, "int", "loadSamples" );
    QUERY->add_arg( QUERY, "int", "n" );
    QUERY->add_mfun( QUERY, spectralsynth_loaded, "int", "loaded" );
    QUERY->add_mfun( QUERY, spectralsynth_numSamples, "int", "numSamples" );

    // --- transport ---
    QUERY->add_mfun( QUERY, spectralsynth_play, "void", "play" );
    QUERY->add_mfun( QUERY, spectralsynth_stop, "void", "stop" );

    // --- incremental processing ---
    QUERY->add_mfun( QUERY, spectralsynth_prepare, "void", "prepare" );
    QUERY->add_mfun( QUERY, spectralsynth_analyzeFrames, "int", "analyzeFrames" );
    QUERY->add_arg( QUERY, "int", "n" );
    QUERY->add_mfun( QUERY, spectralsynth_analyzed, "int", "analyzed" );
    QUERY->add_mfun( QUERY, spectralsynth_processFrames, "int", "processFrames" );
    QUERY->add_arg( QUERY, "int", "n" );
    QUERY->add_mfun( QUERY, spectralsynth_ready, "int", "ready" );
    QUERY->add_mfun( QUERY, spectralsynth_numFrames, "int", "numFrames" );

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

    // --- loopStart ---
    QUERY->add_mfun( QUERY, spectralsynth_setLoopStart, "float", "loopStart" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, spectralsynth_getLoopStart, "float", "loopStart" );

    // --- loopEnd ---
    QUERY->add_mfun( QUERY, spectralsynth_setLoopEnd, "float", "loopEnd" );
    QUERY->add_arg( QUERY, "float", "val" );
    QUERY->add_mfun( QUERY, spectralsynth_getLoopEnd, "float", "loopEnd" );

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

    // --- phaseMode ---
    QUERY->add_mfun( QUERY, spectralsynth_setPhaseMode, "int", "phaseMode" );
    QUERY->add_arg( QUERY, "int", "val" );
    QUERY->add_mfun( QUERY, spectralsynth_getPhaseMode, "int", "phaseMode" );

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
// chunked file loading
//-----------------------------------------------------------------------------
CK_DLL_MFUN( spectralsynth_open )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    Chuck_String * str = GET_NEXT_STRING( ARGS );
    RETURN->v_int = ( obj && str ) ? obj->openFile( API->object->str( str ) ) : 0;
}

CK_DLL_MFUN( spectralsynth_loadSamples )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    t_CKINT n = GET_NEXT_INT( ARGS );
    RETURN->v_int = obj ? obj->loadSamples( (int)n ) : 0;
}

CK_DLL_MFUN( spectralsynth_loaded )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj ? obj->loaded() : 0;
}

CK_DLL_MFUN( spectralsynth_numSamples )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj ? obj->getNumSamples() : 0;
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
// incremental processing
//-----------------------------------------------------------------------------
CK_DLL_MFUN( spectralsynth_prepare )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    if( obj ) obj->prepare();
}

CK_DLL_MFUN( spectralsynth_analyzeFrames )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    t_CKINT n = GET_NEXT_INT( ARGS );
    RETURN->v_int = obj ? obj->analyzeFrames( (int)n ) : 0;
}

CK_DLL_MFUN( spectralsynth_analyzed )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj ? obj->analyzed() : 0;
}

CK_DLL_MFUN( spectralsynth_processFrames )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    t_CKINT n = GET_NEXT_INT( ARGS );
    RETURN->v_int = obj ? obj->processFrames( (int)n ) : 0;
}

CK_DLL_MFUN( spectralsynth_ready )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj ? obj->ready() : 0;
}

CK_DLL_MFUN( spectralsynth_numFrames )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj ? obj->getNumFrames() : 0;
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

CK_DLL_MFUN( spectralsynth_setLoopStart )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->setLoopStart( GET_NEXT_FLOAT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getLoopStart )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->getLoopStart();
}

CK_DLL_MFUN( spectralsynth_setLoopEnd )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->setLoopEnd( GET_NEXT_FLOAT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getLoopEnd )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_float = obj->getLoopEnd();
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

CK_DLL_MFUN( spectralsynth_setPhaseMode )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->setPhaseMode( GET_NEXT_INT( ARGS ) );
}
CK_DLL_MFUN( spectralsynth_getPhaseMode )
{
    SpectralSynth * obj = (SpectralSynth *)OBJ_MEMBER_INT( SELF, spectralsynth_data_offset );
    RETURN->v_int = obj->getPhaseMode();
}
