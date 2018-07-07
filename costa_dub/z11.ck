LONG_WAV l;
"../_SAMPLES/CostaRica/processed/ZOOM0011_ruisseau.wav" => l.read;

.35 / 3. * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(8*data.tick, 4*data.tick);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 7 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  


while(1) {
       100::ms => now;
}
 
