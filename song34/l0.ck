/*
Andrew Zhu Aday M220a Final Project
ConvRev Chugin Examples

ADC => ConvRev
*/
ConvRev cr; Gain g;
.5 => g.gain;

cr => g => dac;

SndBuf2 ir => blackhole;
//"../_SAMPLES/ConvolutionImpulseResponse/st_nicolaes_church.wav" => ir.read; // 48000 sr, mono
//"../_SAMPLES/ConvolutionImpulseResponse/bottle_hall.wav" => ir.read; // 48000 sr, mono
//"../_SAMPLES/ConvolutionImpulseResponse/cement_blocks_1.wav" => ir.read; // 48000 sr, mono
"../_SAMPLES/ConvolutionImpulseResponse/five_columns.wav" => ir.read; // 48000 sr, mono
//"../_SAMPLES/ConvolutionImpulseResponse/small_drum_room.wav" => ir.read; // 48000 sr, mono

/* "../IRs/church_of_gesu.wav" => ir.read; // 44100 sr, mono */
//me.dir() + "./IRs/hagia-sophia.wav" => ir.read; // 48000 sr, mono
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

TriOsc sin0 => LPF l2 => cr; 
7 * 100 => l2.freq;
.8 => sin0.width;
56.0 => sin0.freq;
.0 => sin0.gain;
sin0 => LPF l => dac;
32 * 10 => l.freq;
while (1) {
.05 => sin0.gain;
 0.55 => sin0.phase;
 20::ms => now;
 0.=> sin0.gain;
1::second => now;
  }
