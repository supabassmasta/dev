LONG_WAV l; 
"../_SAMPLES/CostaRica/processed/ZOOM0014.wav" => l.read;
1. => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(16*data.tick, 20::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); 
l $ ST @=> ST @ last; 

STLPF lpf;
lpf.connect(last $ ST , 6 * 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

while(1) {
	     100::ms => now;
}
 
