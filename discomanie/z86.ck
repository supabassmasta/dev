LONG_WAV l;
"../_SAMPLES/Chassin/discomanie.wav" => l.read;
2.0 * data.master_gain => l.buf.gain;
1 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 10* 16 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
