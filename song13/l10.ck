60::second / 135 => dur t;
0 => int cnt;

SinOsc s => ADSR a => dac;
.2 => s.gain;
a.set(3::ms, 100::ms, 0.0001, 10::ms);

while(1) {
  if (cnt%4 == 0) {
   660 => s.freq;
  }
  else            440 => s.freq;

  a.keyOn();

  1 +=> cnt;

  t => now;
}
 
