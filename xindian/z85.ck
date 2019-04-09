LONG_WAV l;
"../_SAMPLES/Chassin/X-indiannodrum.wav" => l.read;
1.15 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(2::ms, 2::ms);
l.start(4 * data.tick /* sync */ , 2* 32 * data.tick  /* offset */ , 2 * 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
