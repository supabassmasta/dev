LOOP_DOUBLE_WAV l;
"../_SAMPLES/" => l.read;
1.0 * data.master_gain => l.buf.gain;
l.AttackRelease(1::ms, 15 * 100::ms);
l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

