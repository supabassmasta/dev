LONG_WAV l;
"../_SAMPLES/Chassin/Ederlezi Do dorien sans bass ni drum_NORMALIZED.wav" => l.read;
0.4 => l.buf.gain;
1 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);

// FULL
//l.start(4 * data.tick /* sync */ ,0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  


// KICK START
//l.start(4 * data.tick /* sync */ ,80 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

// PONT
//l.start(4 * data.tick /* sync */ ,112 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

// BASS START REFRAIN
//l.start(4 * data.tick /* sync */ ,128 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

// STEPPA
l.start(4 * data.tick /* sync */ , (128 + 64) * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

// REFRAIN
//l.start(4 * data.tick /* sync */ , (128 + 64 + 32) * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
	     100::ms => now;
}
 
