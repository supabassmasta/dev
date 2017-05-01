// FFT convolution with static impulse response
// by Perry R. Cook, November 2014
// upsides:  as efficient as it could be, save for
//           constructing a specific fft convolution chugin
// downsides: minimum delay is length of impulse response + buffers
// fix:      break into pieces and overlap add
//  Other fix:  see filter version using my FIR Filter chugin

// our fixed convolution kernal (impulse response)
SndBuf s => FFT ffth => blackhole;

//*******************************************************************************
//Input response recording filename goes here. 
//If using Mini-Audicle, make sure in Mini-Audicle Preferences
//you have set your "Current Directory" in the Miscellaneous tab.
//*******************************************************************************
"CCRMAHallShort.wav" => s.read; // whatever you like (caution of length!!)

2 => int fftSize;
while (fftSize < s.samples())
    2 *=> fftSize;           // next highest power of two
fftSize => int windowSize;   // this is windowsize, only apply to signal blocks
windowSize/2 => int hopSize; // this can any whole fraction of windowsize
2 *=> fftSize;               // zero pad by 2x factor (for convolve)

// our input signal, replace adc with anything you like
SndBuf w => Gain input => FFT fftx => blackhole;  // input signal

//*******************************************************************************
//Sound source to convolve filename/path
//*******************************************************************************
"gtr.wav" => w.read;

IFFT outy => dac;            // our output
fftSize => ffth.size => fftx.size => outy.size; // sizes
Windowing.hann(windowSize) => fftx.window;
windowSize::samp => now;     // load impulse response into h
ffth.upchuck() @=> UAnaBlob H; // spectrum of fixed impulse response
s =< ffth =< blackhole;      // don't need impulse resp signal anymore

complex Z[fftSize/2];
//*******************************************************************************
//Change output gain
//*******************************************************************************
10000 => input.gain;          // fiddle with this how you like/need

while (true)  {
    fftx.upchuck() @=> UAnaBlob X; // spectrum of input signal
    
    // multiply spectra bin by bin (complex for free!):
    for(0 => int i; i < fftSize/2; i++ ) {
        fftx.cval(i) * H.cval(i) => Z[i];    
    }    
    outy.transform( Z );      // take ifft
    hopSize :: samp => now;   // and do it all again
}
