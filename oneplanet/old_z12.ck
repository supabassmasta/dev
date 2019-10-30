LONG_WAV l;
"../_SAMPLES/oneplanet/bass.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(1 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 4 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
