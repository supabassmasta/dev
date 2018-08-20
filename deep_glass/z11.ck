LONG_WAV l;
"../_SAMPLES/CostaRica/processed/ZOOM0016.wav" => l.read;
0.1 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(3::ms, 3::ms);
l.start(4 * data.tick /* sync */ , 44 * data.tick  /* offset */ , 15 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
