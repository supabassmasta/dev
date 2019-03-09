class STRECCONV extends ST{
  Gain gainl => outl;
  Gain gainr => outr;
  1. => gainl.gain => gainr.gain;
  
  // Direct path
  Delay dl => gainl;
  Delay dr => gainr;

  float dry;

  SndBuf ir;
  FFT fftir;
  int fftSize;
  int windowSize;
  int hopSize;

  UAnaBlob H;
  complex Z[0];
  FFT fftx;
  IFFT outy;


  fun void loadir() {
    ir => fftir => blackhole;

    2 => fftSize;
    while (fftSize < ir.samples()) {
      2 *=> fftSize;           // next highest power of two
    }

    fftSize => windowSize;   // this is windowsize, only apply to signal blocks
    windowSize/2 => hopSize; // this can any whole fraction of windowsize
    2 *=> fftSize;               // zero pad by 2x factor (for convolve)
    <<<"fftSize :", fftSize, " samp, ", fftSize * 1::samp / 1::ms," ms">>>;

    // config ffts sizes and window
    fftSize => fftir.size => fftx.size => outy.size; // sizes
    Windowing.hann(windowSize) => fftx.window;

    fftSize/2 => Z.size;

    0 => ir.pos;
//    windowSize::samp => now;     // load impulse response into h
    fftSize::samp => now;     // load impulse response into h
    fftir.upchuck() @=> H; // spectrum of fixed impulse response
    ir =< fftir =< blackhole;      // don't need impulse resp signal anymore

    <<<"Convolution IR Ready">>>;
  }


  ////// INPUT ////// 

  // TODO Add a delay for input and a direct out with dry/wet param

  Gain input => fftx => blackhole;  // input signal

  fun void connect(ST @ tone) {
    // MONO AT NOW
    tone.left() => input;
    tone.right() => input;

    // Direct path
    fftSize/2 * 1::samp => dl.max => dl.delay;
    fftSize/2 * 1::samp => dr.max => dr.delay;
    dry => dl.gain => dr.gain;
    tone.left() => dl;
    tone.right() => dr;

    1. - dry => outy.gain;
  }

  ////// OUTPUT ////// 
  outy => gainl;  // MONO AT NOW         
  outy => gainr;      
//  outy => dac;      

  //*******************************************************************************
  //Change output gain
  //*******************************************************************************
  //10 * 1000 => input.gain;          // fiddle with this how you like/need


  fun void _rec (dur d, string s){ 
    REC rec;

    //wait fft to start
    fftSize/2 * 1::samp + 10::ms /* delay before seq no_sync start */ => now;

    // rec.rec(128*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */);
    rec.rec_no_sync(d, s); 


  } 

  fun void rec(dur d, string s) {
    spork ~ _rec (d, s);
  }

  fun void  _process() {

    while (true)  {
      fftx.upchuck() @=> UAnaBlob X; // spectrum of input signal

      // multiply spectra bin by bin (complex for free!):
      for(0 => int i; i < fftSize/2; i++ ) {
        fftx.cval(i) * H.cval(i) => Z[i];    
      }    
      outy.transform( Z );      // take ifft
      hopSize :: samp => now;   // and do it all again
    }

  }

  fun void  process() {
    spork ~ _process();
  }

}

///////////////////////////////////////////////////////////////////////////

TONE t;
t.reg(PLOC0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
8_1_1_1_" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//
t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//t.go();   t $ ST @=> ST @ last; 



///////////////////////////////////////////////////////////////////////////




STRECCONV strecconv;
10 * 1000 => strecconv.input.gain;
.6 => strecconv.dry;

"../_SAMPLES/ConvolutionImpulseResponse/in_the_silo_revised.wav" => strecconv.ir.read; 
//"../_SAMPLES/ConvolutionImpulseResponse/on_a_star_jsn_fade_out.wav" => strecconv.ir.read;
//"../_SAMPLES/ConvolutionImpulseResponse/chateau_de_logne_outside.wav" => strecconv.ir.read;
strecconv.loadir();

/////   /!\ make seq start after loading IR /!\   ///////////////////
t.no_sync(); // Config it no_sync
t.go();
////////////////////////////////////////////////////////////////

strecconv.connect(t /* ST */);
strecconv.process();
strecconv.rec(16 * data.tick /* length */, "test3.wav" /* file name */ );

while(1) {
       100::ms => now;
}
 
