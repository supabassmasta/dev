
LONG_WAV l;
"../_SAMPLES/Hawking/data_paradox.wav" => l.read;
0.6 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STAUTOPAN autopan;
autopan.connect(last $ ST, .1 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .2);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
