SinOsc s => ADSR a => dac;
.2 => s.gain;
a.set(3::ms, 100::ms, 0.0001, 10::ms);
0 => int cnt;
float ratio;

500::ms => dur tick;

while(1) {

  if (cnt%4 == 0) {
    660 => s.freq;
    (1. + (cnt $ float)/100.) =>  ratio;
    MASTER_SEQ3.update_tick(now, tick *ratio *4, 4);
//    MASTER_SEQ3.update_ref_times(now, tick *ratio *4);
//    MASTER_SEQ3.update_durations(tick *ratio *4, 4);
  }
  else            440 => s.freq;

  a.keyOn();

  1 +=> cnt;
  tick * ratio => now;

}
 
