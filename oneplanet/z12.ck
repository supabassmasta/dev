LONG_WAV l;
"../_SAMPLES/oneplanet/bass_light.wav" => l.read;
0.78 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(20::ms, 20::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 8 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
