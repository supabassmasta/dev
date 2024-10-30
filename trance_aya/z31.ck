LONG_WAV l; 
"../_SAMPLES/CostaRica/processed/ZOOM0014_Processed.wav" => l.read;
1.1 => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(8*data.tick, 4*data.tick );
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 128 * data.tick /* loop (0::ms == disable) */ , 16 * data.tick /* END sync */); 
l $ ST @=> ST @ last; 

STLPF lpf;
lpf.connect(last $ ST , 2 * 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STBRF bpf;
bpf.connect(last $ ST , 39 * 101 /* freq */  , 1.0 /* Q */  );       bpf $ ST @=>  last; 
STBRF bpf2;
bpf2.connect(last $ ST , 24 * 101 /* freq */  , 1.0 /* Q */  );       bpf2 $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 23*100 /* freq */  , 1.2 /* Q */  );       hpf $ ST @=>  last; 

while(1) {
	     100::ms => now;
}
 
