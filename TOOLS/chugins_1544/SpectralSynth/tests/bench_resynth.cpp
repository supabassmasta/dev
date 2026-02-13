//-----------------------------------------------------------------------------
// bench_resynth.cpp — benchmark for SpectralSynth::resynthesize()
//
// Loads a WAV file, feeds it to SpectralSynth via setInput(), and
// measures the execution time of the resynthesis under various settings.
//
// Build:  make  (from this directory)
// Run:    ./bench_resynth
//-----------------------------------------------------------------------------

// include SpectralSynth.cpp (brings in the class + chugin.h + AudioFFT.h)
#include "../SpectralSynth.cpp"

#include <cstdio>
#include <cstdint>
#include <chrono>
#include <vector>


//-----------------------------------------------------------------------------
// minimal WAV loader — 16-bit PCM mono only
//-----------------------------------------------------------------------------
static bool loadWav( const char * path, std::vector<float> & samples, int & srate )
{
    FILE * f = fopen( path, "rb" );
    if( !f )
    {
        fprintf( stderr, "error: cannot open '%s'\n", path );
        return false;
    }

    // RIFF header
    char riff[4];
    fread( riff, 1, 4, f );
    if( riff[0] != 'R' || riff[1] != 'I' || riff[2] != 'F' || riff[3] != 'F' )
    {
        fprintf( stderr, "error: not a RIFF file\n" );
        fclose( f );
        return false;
    }

    uint32_t fileSize;
    fread( &fileSize, 4, 1, f );

    char wave[4];
    fread( wave, 1, 4, f );

    // find fmt and data chunks
    int16_t numChannels = 0, bitsPerSample = 0;
    int32_t sampleRate = 0;
    uint32_t dataSize = 0;
    bool foundFmt = false, foundData = false;

    while( !foundData && !feof(f) )
    {
        char chunkId[4];
        uint32_t chunkSize;
        if( fread( chunkId, 1, 4, f ) != 4 ) break;
        if( fread( &chunkSize, 4, 1, f ) != 1 ) break;

        if( chunkId[0] == 'f' && chunkId[1] == 'm' && chunkId[2] == 't' && chunkId[3] == ' ' )
        {
            int16_t audioFormat;
            fread( &audioFormat, 2, 1, f );
            fread( &numChannels, 2, 1, f );
            fread( &sampleRate, 4, 1, f );
            // skip byteRate + blockAlign
            fseek( f, 6, SEEK_CUR );
            fread( &bitsPerSample, 2, 1, f );
            // skip any extra fmt bytes
            long remaining = (long)chunkSize - 16;
            if( remaining > 0 ) fseek( f, remaining, SEEK_CUR );
            foundFmt = true;
        }
        else if( chunkId[0] == 'd' && chunkId[1] == 'a' && chunkId[2] == 't' && chunkId[3] == 'a' )
        {
            dataSize = chunkSize;
            foundData = true;
        }
        else
        {
            fseek( f, chunkSize, SEEK_CUR );
        }
    }

    if( !foundFmt || !foundData )
    {
        fprintf( stderr, "error: missing fmt or data chunk\n" );
        fclose( f );
        return false;
    }

    if( numChannels != 1 || bitsPerSample != 16 )
    {
        fprintf( stderr, "error: expected 16-bit mono, got %d-bit %d-channel\n",
                 bitsPerSample, numChannels );
        fclose( f );
        return false;
    }

    srate = sampleRate;
    int numSamples = dataSize / 2;
    samples.resize( numSamples );

    std::vector<int16_t> raw( numSamples );
    fread( raw.data(), 2, numSamples, f );
    fclose( f );

    for( int i = 0; i < numSamples; i++ )
        samples[i] = (float)raw[i] / 32768.0f;

    return true;
}


//-----------------------------------------------------------------------------
// benchmark helper
//-----------------------------------------------------------------------------
struct BenchResult
{
    const char * label;
    double ms;
};

static BenchResult bench( const char * label, SpectralSynth & ss,
                          const std::vector<float> & audio, int runs )
{
    // warmup
    ss.setInput( audio );

    // timed runs
    auto start = std::chrono::high_resolution_clock::now();
    for( int i = 0; i < runs; i++ )
        ss.setInput( audio );
    auto end = std::chrono::high_resolution_clock::now();

    double totalMs = std::chrono::duration<double, std::milli>( end - start ).count();
    double avgMs = totalMs / (double)runs;

    printf( "  %-40s  %8.2f ms  (avg of %d runs)\n", label, avgMs, runs );

    return { label, avgMs };
}


//-----------------------------------------------------------------------------
// incremental benchmark helper
//-----------------------------------------------------------------------------
static void benchIncremental( const char * label, SpectralSynth & ss,
                              const std::vector<float> & audio, int batchSize, int runs )
{
    // warmup
    ss.setInput( audio );

    double totalPrepareMs = 0.0;
    double totalProcessMs = 0.0;

    for( int r = 0; r < runs; r++ )
    {
        // time prepare()
        auto t0 = std::chrono::high_resolution_clock::now();
        ss.prepare();
        auto t1 = std::chrono::high_resolution_clock::now();

        totalPrepareMs += std::chrono::duration<double, std::milli>( t1 - t0 ).count();

        // time processFrames() in batches
        auto t2 = std::chrono::high_resolution_clock::now();
        while( ss.ready() == 0 )
            ss.processFrames( batchSize );
        auto t3 = std::chrono::high_resolution_clock::now();

        totalProcessMs += std::chrono::duration<double, std::milli>( t3 - t2 ).count();
    }

    double avgPrepare = totalPrepareMs / (double)runs;
    double avgProcess = totalProcessMs / (double)runs;
    double avgTotal = avgPrepare + avgProcess;

    printf( "  %-40s  prepare: %6.2f ms  process: %6.2f ms  total: %6.2f ms  (batch=%d, avg of %d)\n",
            label, avgPrepare, avgProcess, avgTotal, batchSize, runs );
}


//-----------------------------------------------------------------------------
// main
//-----------------------------------------------------------------------------
int main()
{
    const char * wavPath = "../Breathchoir18.wav";
    const int RUNS = 10;

    // load WAV
    std::vector<float> audio;
    int srate;
    if( !loadWav( wavPath, audio, srate ) )
        return 1;

    printf( "loaded: %s\n", wavPath );
    printf( "  samples: %d  srate: %d  duration: %.2f s\n\n",
            (int)audio.size(), srate, (double)audio.size() / srate );

    printf( "benchmarking resynthesize() (%d runs each):\n\n", RUNS );

    // --- test 1: default settings (fftSize=2048, overlap=4, no effects) ---
    {
        SpectralSynth ss( srate );
        bench( "default (2048, overlap 4)", ss, audio, RUNS );
    }

    // --- test 2: pitch shift +5 semitones ---
    {
        SpectralSynth ss( srate );
        ss.setPitchShift( 5.0 );
        bench( "pitch +5 (2048, overlap 4)", ss, audio, RUNS );
    }

    // --- test 3: pitch shift -12 semitones ---
    {
        SpectralSynth ss( srate );
        ss.setPitchShift( -12.0 );
        bench( "pitch -12 (2048, overlap 4)", ss, audio, RUNS );
    }

    // --- test 4: larger FFT ---
    {
        SpectralSynth ss( srate );
        ss.setFftSize( 4096 );
        ss.setPitchShift( 5.0 );
        bench( "pitch +5 (4096, overlap 4)", ss, audio, RUNS );
    }

    // --- test 5: higher overlap ---
    {
        SpectralSynth ss( srate );
        ss.setOverlap( 8 );
        ss.setPitchShift( 5.0 );
        bench( "pitch +5 (2048, overlap 8)", ss, audio, RUNS );
    }

    // --- test 6: large FFT + high overlap ---
    {
        SpectralSynth ss( srate );
        ss.setFftSize( 4096 );
        ss.setOverlap( 8 );
        ss.setPitchShift( 5.0 );
        bench( "pitch +5 (4096, overlap 8)", ss, audio, RUNS );
    }

    // --- test 7: with spectral blur ---
    {
        SpectralSynth ss( srate );
        ss.setPitchShift( 5.0 );
        ss.setSpectralBlur( 2.0 );
        bench( "pitch +5, blur 2.0 (2048)", ss, audio, RUNS );
    }

    // --- test 8: with spectral gate ---
    {
        SpectralSynth ss( srate );
        ss.setPitchShift( 5.0 );
        ss.setSpectralGate( 0.3 );
        bench( "pitch +5, gate 0.3 (2048)", ss, audio, RUNS );
    }

    // --- test 9: robotize ---
    {
        SpectralSynth ss( srate );
        ss.setRobotize( 1 );
        bench( "robotize (2048, overlap 4)", ss, audio, RUNS );
    }

    // --- test 10: whisperize ---
    {
        SpectralSynth ss( srate );
        ss.setWhisperize( 1 );
        bench( "whisperize (2048, overlap 4)", ss, audio, RUNS );
    }

    // --- test 11: phase mode off ---
    {
        SpectralSynth ss( srate );
        ss.setPitchShift( 5.0 );
        ss.setPhaseMode( 0 );
        bench( "pitch +5, phaseMode off (2048)", ss, audio, RUNS );
    }

    // --- incremental processing benchmarks ---
    printf( "\nbenchmarking incremental prepare()+processFrames():\n\n" );

    {
        SpectralSynth ss( srate );
        ss.setPitchShift( 5.0 );
        benchIncremental( "pitch +5, batch 50", ss, audio, 50, RUNS );
    }

    {
        SpectralSynth ss( srate );
        ss.setPitchShift( 5.0 );
        benchIncremental( "pitch +5, batch 100", ss, audio, 100, RUNS );
    }

    {
        SpectralSynth ss( srate );
        ss.setPitchShift( 5.0 );
        benchIncremental( "pitch +5, batch all", ss, audio, 100000, RUNS );
    }

    {
        SpectralSynth ss( srate );
        benchIncremental( "default, batch 50", ss, audio, 50, RUNS );
    }

    printf( "\ndone.\n" );
    return 0;
}
