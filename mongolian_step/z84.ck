LONG_WAV l;
"../_SAMPLES/mongolian_step/Mongolian step with bass.wav" => l.read;
0.7 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 30 * 16 * data.tick  /* offset */ , 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

//STLPF lpf;
//lpf.connect(last $ ST , 3 * 100 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
