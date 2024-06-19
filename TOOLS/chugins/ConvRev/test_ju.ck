/*
Andrew Zhu Aday M220a Final Project
ConvRev Chugin Examples

ADC => ConvRev
*/
ConvRev cr; Gain g;
.5 => g.gain;

cr => g => dac;

SndBuf2 ir => blackhole;

/* "../IRs/church_of_gesu.wav" => ir.read; // 44100 sr, mono */
me.dir() + "./IRs/hagia-sophia.wav" => ir.read; // 48000 sr, mono
/* "../IRs/musikvereinIR.wav" => ir.read; // 48000 sr, mono */
/* "../IRs/small.wav" => ir.read; // 44100 sr, stereo */

ir.samples() => cr.order;
cr.order() => int order;
for (0 => int i; i < order; i++) {
  /* cr.coeff(i, ir.valueAt(i*2));  // do this if the IR is stereo */
  cr.coeff(i, ir.valueAt(i));  // do this if IR is mono
}

256 => cr.blocksize; // set to any power of 2
cr.init();  // initialize the conv rev engine

SinOsc sin0 => cr; 
440.0 => sin0.freq;
.0 => sin0.gain;
sin0 => dac;

while (1) {
.1 => sin0.gain;
 50::ms => now;
 0.=> sin0.gain;
5::second => now;
  }
