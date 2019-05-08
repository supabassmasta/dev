LOOP_WAV l;
"../_SAMPLES/Chassin/something_blue/something bass.wav" => l.read;
0.45 * data.master_gain => l.buf.gain;
l.AttackRelease(1::ms, 100::ms);
l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;   


//LONG_WAV l;
//"../_SAMPLES/Chassin/something_blue/something bass.wav" => l.read;
//0.45 * data.master_gain => l.buf.gain;
//0 => l.update_ref_time;
//l.AttackRelease(0::ms, 0::ms);
//l.start(8 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 8 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
