LONG_WAV l;
"../_SAMPLES/mongolian_step/Mongolian step with bass.wav" => l.read;
0.7 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 40 * 8 * data.tick  /* offset */ ,2 * 8 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
