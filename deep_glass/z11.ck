LONG_WAV l;
"../_SAMPLES/CostaRica/processed/ZOOM0016.wav" => l.read;
0.08 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(1*data.tick, 1*data.tick);
l.start(1 * data.tick /* sync */ , 44 * data.tick  /* offset */ , 15 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STLPF lpf;
lpf.connect(last $ ST , 17 * 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
