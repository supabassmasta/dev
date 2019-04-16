LOOP_WAV l;
"../_SAMPLES/dhoomtala_chill/Bass basic.wav" => l.read;
0.22 * data.master_gain => l.buf.gain;
l.AttackRelease(3::ms, 100::ms);
l.start(4 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;   
while(1) {
       100::ms => now;
}


