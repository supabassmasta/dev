//SYNC sy;
//sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , .5 * data.tick/* offset */); 

LOOP_DOUBLE_WAV l;
"../_SAMPLES/dhoomtala_chill/StDr theme.wav" => l.read;
0.2 * data.master_gain => l.buf.gain => l.buf2.gain;
l.AttackRelease(1::ms,  100::ms);
l.start(4 * data.tick /* sync */ ,   4 * data.tick /* END sync */ ,  16 * data.tick /* loop */); l $ ST @=> ST @ last;   

while(1) {
       100::ms => now;
}


