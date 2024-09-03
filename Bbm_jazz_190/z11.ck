LONG_WAV l;
"../_SAMPLES/Bbm_jazz_190/Bbm_jazz_190.wav" => l.read;
7 * 0.01 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(16 * data.tick /* sync */ , 0 * data.tick  /* offset */ , l.buf.length()/* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
