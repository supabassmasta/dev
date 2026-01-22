LONG_WAV l;
"BEAT1.wav" => l.read;
0.5 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(8 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 64 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 

