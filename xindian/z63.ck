//LOOP_WAV l;
//"../_SAMPLES/dhoomtala_chill/bells1.wav" => l.read;
//1.2 * data.master_gain => l.buf.gain;
//l.AttackRelease(50::ms, 100::ms);
//l.start(4 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;   
LONG_WAV l;
"../_SAMPLES/dhoomtala_chill/bells1.wav" => l.read;
1.2 * data.master_gain => l.buf.gain;
1 => l.update_ref_time;
l.AttackRelease(50::ms, 100::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 4 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  


while(1) {
       100::ms => now;
}
 
