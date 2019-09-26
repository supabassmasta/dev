LOOP_WAV l;
"../_SAMPLES/trippy_cat/arp_0.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
l.AttackRelease(1::ms, 100::ms);
l.start(16 * data.tick /* sync */ ,   16 * data.tick /* END sync */); l $ ST @=> ST @ last;   

while(1) {
       100::ms => now;
}
 
