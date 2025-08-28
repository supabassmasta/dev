LONG_WAV l;
"../_SAMPLES/Chassin/archipel 3.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ ,28.63::second  + 20 * 16 * data.tick  /* offset */ , 14 * 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  


<<<"START">>>;

while(1) {
       100::ms => now;
}
 
