LONG_WAV l;
"../_SAMPLES/Chassin/Ederlezi Do dorien sans bass ni drum_NORMALIZED.wav" => l.read;
0.4 => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
	     100::ms => now;
}
 
