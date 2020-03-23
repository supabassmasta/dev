LONG_WAV l;
"../_SAMPLES/ambient_universe/bass1.wav" => l.read;
7.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(10::ms, 4000::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STLPF lpf;
lpf.connect(last $ ST , 22 * 10 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .2 /* span 0..1 */, data.tick * 1 / 2 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
