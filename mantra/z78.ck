LONG_WAV l;
//"../_SAMPLES/Chassin/Mantra tibétain-takeyourtime_NORMALIZED_RESYNC.wav" => l.read;
"../_SAMPLES/Chassin/fin mantra (sans drum).wav" => l.read;

.8 => l.buf.gain;
1 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
//l.start(4 * data.tick /* sync */ , 0 * data.tick + 53::ms  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  
l.start(4 * data.tick /* sync */ , 96 * 16 * data.tick + 53::ms  /* offset */ , 24 * 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
	     100::ms => now;
}
 
