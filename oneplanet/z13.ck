LONG_WAV l;
"../_SAMPLES/oneplanet/bass.wav" => l.read;
0.97 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(20::ms, 20::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 4 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
