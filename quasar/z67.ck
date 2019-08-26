LONG_WAV l;
"pad1.wav" => l.read;
0.7 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(4 * data.tick, 4 * data.tick);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 24 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
