LONG_WAV l;
"../_SAMPLES/dhoomtala_chill/Bass ragga.wav" => l.read;
0.15 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(3::ms, 190::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 8 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}


