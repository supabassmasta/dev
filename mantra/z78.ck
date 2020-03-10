LONG_WAV l;
//"../_SAMPLES/Chassin/Mantra tibétain-takeyourtime_NORMALIZED_RESYNC.wav" => l.read;
"../_SAMPLES/Chassin/Mantra II MEL chaton.wav" => l.read;

0.8 => l.buf.gain;
1 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 58 *  16 * data.tick  /* offset */ , 20 * 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STHPFC2 hpfc2;
hpfc2.connect(last $ ST , HW.lpd8.potar[1][7] /* freq */  , HW.lpd8.potar[1][8] /* Q */  );       hpfc2 $ ST @=>  last; 

while(1) {
	     100::ms => now;
}
 
