LONG_WAV l;
"../_SAMPLES/Chassin/Dhoomtala chill_mono.wav" => l.read;
1.2 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , (4 * 16 ) * data.tick  /* offset */ , 8 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  
//l.start(4 * data.tick /* sync */ , (7 * 16 ) * data.tick  /* offset */ , 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  
//l.start(4 * data.tick /* sync */ , (11 * 16 ) * data.tick  /* offset */ , 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  
//l.start(4 * data.tick /* sync */ , (13 * 16 ) * data.tick  /* offset */ , 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
