LONG_WAV l;
"../_SAMPLES/Chassin/Inawahnodrum.wav" => l.read;
1.3 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(8 * data.tick /* sync */ , 2 * 16 * data.tick  /* offset */ , 8 * 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STHPF hpf;
hpf.connect(last $ ST , 1000 /* freq */  , 2.0 /* Q */  );       hpf $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
