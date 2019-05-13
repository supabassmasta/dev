LOOP_DOUBLE_WAV l;
"../_SAMPLES/inawah/pads.wav" => l.read;
1.0 * data.master_gain => l.buf.gain => l.buf2.gain;
l.AttackRelease(1::ms, 15 * 100::ms);
l.start(8 * data.tick /* sync */ ,   1 * data.tick /* END sync */ ,  8 * data.tick /* loop */); l $ ST @=> ST @ last;   

while(1) {
       100::ms => now;
}
 
