LONG_WAV l;
"../_SAMPLES/Chassin/archipel 3.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(0 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

28.63::second => now;

MASTER_SEQ3.update_ref_times(now, data.tick * 16 * 128 );

<<<"START">>>;

while(1) {
       100::ms => now;
}
 
