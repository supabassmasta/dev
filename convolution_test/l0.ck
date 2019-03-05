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
//"../_SAMPLES/ConvolutionImpulseResponse/in_the_silo_revised.wav" => s.read; // whatever you like (caution of length!!)
"../_SAMPLES/ConvolutionImpulseResponse/on_a_star_jsn_fade_out.wav" => s.read; // whatever you like (caution of length!!)
//"../_SAMPLES/ConvolutionImpulseResponse/chateau_de_logne_outside.wav" => s.read; // whatever you like (caution of length!!)

2 => int fftSize;
while (fftSize < s.samples())
    2 *=> fftSize;           // next highest power of two
fftSize => int windowSize;   // this is windowsize, only apply to signal blocks
windowSize/2 => int hopSize; // this can any whole fraction of windowsize
2 *=> fftSize;               // zero pad by 2x factor (for convolve)
<<<"fftSize :", fftSize, " samp, ", fftSize * 1::samp / 1::ms," ms">>>;


// our input signal, replace adc with anything you like
SndBuf w => Gain input => FFT fftx => blackhole;  // input signal


IFFT outy => dac;            // our output
fftSize => ffth.size => fftx.size => outy.size; // sizes
Windowing.hann(windowSize) => fftx.window;
windowSize::samp => now;     // load impulse response into h
ffth.upchuck() @=> UAnaBlob H; // spectrum of fixed impulse response
s =< ffth =< blackhole;      // don't need impulse resp signal anymore

<<<"Convolution IR Ready">>>;


complex Z[fftSize/2];
//*******************************************************************************
//Change output gain
//*******************************************************************************
10 * 1000 => input.gain;          // fiddle with this how you like/need

//*******************************************************************************
//Sound source to convolve filename/path
//*******************************************************************************
"./ploc.wav" => w.read;

fun void f1 (){ 
while(1) {
     4*hopSize :: samp => now;
     0 => w.pos;
}
 
   } 
   spork ~ f1 ();
    
fun void f2 (){ 
 REC rec;
// rec.rec(128*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */);
 rec.rec_no_sync(8  * 32*data.tick, "test.wav"); 


   } 
   spork ~ f2 ();
    

while (true)  {
    fftx.upchuck() @=> UAnaBlob X; // spectrum of input signal
    
    // multiply spectra bin by bin (complex for free!):
    for(0 => int i; i < fftSize/2; i++ ) {
        fftx.cval(i) * H.cval(i) => Z[i];    
    }    
    outy.transform( Z );      // take ifft
    hopSize :: samp => now;   // and do it all again
}
