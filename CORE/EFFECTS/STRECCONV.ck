public class STRECCONV extends ST{
  Gain gainl => outl;
  Gain gainr => outr;
  1. => gainl.gain => gainr.gain;
  
  // Direct path
  Delay dl => gainl;
  Delay dr => gainr;

  float dry;
  dur predelay;
  Delay predl;
  Delay predr;

  SndBuf2 ir;
  FFT fftirl;
  FFT fftirr;
  int fftSize;
  int windowSize;
  int hopSize;

  UAnaBlob Hl;
  UAnaBlob Hr;
  complex Zl[0];
  complex Zr[0];
  FFT fftxl;
  FFT fftxr;
  IFFT outyl;
  IFFT outyr;


  fun void loadir() {
    ir.chan(0) => fftirl => blackhole;
    ir.chan(1) => fftirr => blackhole;

    2 => fftSize;
    while (fftSize < ir.samples()) {
      2 *=> fftSize;           // next highest power of two
    }

    fftSize => windowSize;   // this is windowsize, only apply to signal blocks
    windowSize/2 => hopSize; // this can any whole fraction of windowsize
    2 *=> fftSize;               // zero pad by 2x factor (for convolve)
    <<<"fftSize :", fftSize, " samp, ", fftSize * 1::samp / 1::ms," ms">>>;

    // config ffts sizes and window
    fftSize => fftirl.size => fftxl.size => outyl.size; // sizes
    fftSize => fftirr.size => fftxr.size => outyr.size; // sizes
    Windowing.hann(windowSize) => fftxl.window;
    Windowing.hann(windowSize) => fftxr.window;

    fftSize/2 => Zl.size => Zr.size;

    0 => ir.pos;
//    windowSize::samp => now;     // load impulse response into h
    fftSize::samp => now;     // load impulse response into h
    fftirl.upchuck() @=> Hl; // spectrum of fixed impulse response
    fftirr.upchuck() @=> Hr; // spectrum of fixed impulse response
    ir.chan(0) =< fftirl =< blackhole;      // don't need impulse resp signal anymore
    ir.chan(1) =< fftirr =< blackhole;      // don't need impulse resp signal anymore

    <<<"Convolution IR Ready">>>;
  }


  ////// INPUT ////// 
  Gain inputl => fftxl => blackhole; 
  Gain inputr => fftxr => blackhole;

  fun void connect(ST @ tone) {
    // MONO AT NOW
    tone.left() => inputl;
    tone.right() => inputr;

    // Direct path
    fftSize/2 * 1::samp => dl.max => dl.delay;
    fftSize/2 * 1::samp => dr.max => dr.delay;
    dry => dl.gain => dr.gain;
    tone.left() => dl;
    tone.right() => dr;

    // Rev path
    1. - dry => outyl.gain;
    1. - dry => outyr.gain;
    predelay => predl.max => predl.delay;
    predelay => predr.max => predr.delay;
  }

  ////// OUTPUT ////// 
  outyl => predl => gainl;  
  outyr => predr => gainr;      

  fun void _rec (dur d, string s){ 
    REC rec;

    //wait fft to start
    fftSize/2 * 1::samp + 10::ms /* delay before seq no_sync start */ => now;

    rec.rec_no_sync(d, s); 
  } 

  fun void rec(dur d, string s) {
    spork ~ _rec (d, s);
  }

  fun void  _process() {

    while (true)  {
      fftxl.upchuck() @=> UAnaBlob Xl; // spectrum of input signal
      fftxr.upchuck() @=> UAnaBlob Xr; // spectrum of input signal

      // multiply spectra bin by bin (complex for free!):
      for(0 => int i; i < fftSize/2; i++ ) {
        fftxl.cval(i) * Hl.cval(i) => Zl[i];    
        fftxr.cval(i) * Hr.cval(i) => Zr[i];    
      }    
      outyl.transform( Zl );      // take ifft
      outyr.transform( Zr );      // take ifft
      hopSize :: samp => now;   // and do it all again
    }

  }

  fun void  process() {
    spork ~ _process();
  }

}


