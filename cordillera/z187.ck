LONG_WAV l;
"../_SAMPLES/Chassin/Cordillera.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 16* 16 * data.tick  /* offset */ ,10* 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

1=> int cnt;
SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 
while(1) {
  <<<cnt>>>;
  1+=> cnt;
  data.tick=> now;
}

 
