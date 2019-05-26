LOOP_DOUBLE_WAV l;
"../_SAMPLES/STUDIO/deep_glass/BamboosEcho_2Echo.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
l.AttackRelease(1::ms, 15 * 100::ms);
l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;   

while(1) {
       100::ms => now;
}
 
