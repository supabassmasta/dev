ST st;
SinOsc s => st.mono_in;
.2 => s.gain;
595 => s.freq;

//st.mono() => NRev rev =>  dac;
//.4 => rev.mix;

STAUTOPAN autopan;
autopan.connect(st $ ST, .9 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );  

while(1) {
       100::ms => now;
}
 
