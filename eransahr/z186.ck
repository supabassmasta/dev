LONG_WAV l;
"../_SAMPLES/Eransahr/Eransahr.wav" => l.read;
0.7 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(  4 * data.tick  /* sync */ , ( 3 * 16 + 20) * data.tick  /* offset */ , 1 * 32 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
