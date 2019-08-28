LONG_WAV l;
"../_SAMPLES/oneplanet/trance_synts_2.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 100::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
