LOOP_WAV l;
"../_SAMPLES/dhoomtala_chill/glitch.wav" => l.read;
1.2 * data.master_gain => l.buf.gain;
l.AttackRelease(1::ms, 100::ms);
l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;   

while(1) {
       100::ms => now;
}


