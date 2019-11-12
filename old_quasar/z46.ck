LONG_WAV l;
"../_SAMPLES/quasar/theme0_arp.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 30::ms);
l.start(8 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 64 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
