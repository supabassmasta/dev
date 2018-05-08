
LONG_WAV l;
"../_SAMPLES/Chassin/Icario chant G D C test2.wav" => l.read;
1. => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 32 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); 


while(1) {
	     100::ms => now;
}
 
