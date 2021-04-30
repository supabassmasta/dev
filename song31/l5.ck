//SYNC sy;
////sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , .5 * data.tick/* offset */); 

//   LOOP_DOUBLE_WAV l;
//   "../_SAMPLES/dhoomtala_chill/StDr intro.wav" => l.read;
//   0.25 * data.master_gain => l.buf.gain => l.buf2.gain;
//   l.AttackRelease(1::ms, 3 * 100::ms);
//   l.start(4 * data.tick /* sync */ ,   4 * data.tick /* END sync */, 8 * data.tick /* loop */); l $ ST @=> ST @ last;   

//   LONG_WAV l;
//   "../_SAMPLES/dhoomtala_chill/StDr intro.wav" => l.read;
//   1.0 * data.master_gain => l.buf.gain;
//   0 => l.update_ref_time;
//   l.AttackRelease(0::ms, 0::ms);
//   l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 8 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

//  LOOP_WAV l;
//  "../_SAMPLES/dhoomtala_chill/StDr intro.wav" => l.read;
//  1.0 * data.master_gain => l.buf.gain;
//  l.AttackRelease(1::ms, 100::ms);
//  l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;   


//  LOOP_DOUBLE_WAV l;
//  "../_SAMPLES/dhoomtala_chill/StDr intro.wav" => l.read;
//  1.0 * data.master_gain => l.buf.gain => l.buf2.gain;
//  l.AttackRelease(1::ms, 15 * 100::ms);
//  l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */ ,  8 * data.tick /* loop */); l $ ST @=> ST @ last;   
//

//LOOP_DOUBLE_WAV_SYNC l;
//"../_SAMPLES/dhoomtala_chill/StDr intro.wav" => l.read;
//1.0 * data.master_gain => l.buf.gain => l.buf2.gain;
//l.AttackRelease(1::ms, 15 * 100::ms);
//l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */ ,  8 * data.tick /* loop */); l $ ST @=> ST @ last;   
//
140 => data.bpm;   (60.0/data.bpm)::second => data.tick;

LOOP_WAV l;
"../_SAMPLES/mantra/Dub Percs 1 BPM126_80_adjusted.wav" => l.read;
0.3 * data.master_gain => l.buf.gain;
l.AttackRelease(1::ms, 100::ms);
l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;   
while(1) {
       100::ms => now;
}


