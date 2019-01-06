LONG_WAV l;
"bass.wav" => l.read;
1.0  * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(4 * data.tick,4 * data.tick );
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 16 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
