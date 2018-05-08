
LONG_WAV l;
"../_SAMPLES/Chassin/Icario chant G D C test2.wav" => l.read;
0.7 => l.buf.gain;
1 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 9.5 * 64 * data.tick  /* offset */ , 4 * 32 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); 


while(1) {
	     100::ms => now;
}
 
