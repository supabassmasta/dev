LONG_WAV l;
//"../_SAMPLES/Chassin/Mantra tibétain-takeyourtime_NORMALIZED_RESYNC.wav" => l.read;
"../_SAMPLES/Chassin/Mantra tibétain-takeyourtime_NORMALIZED_RESYNC3.wav" => l.read;
1.0 => l.buf.gain;
1 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
//l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  
// BEAT START
l.start(4 * data.tick /* sync */ , 128 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
	     100::ms => now;
}
 
