SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , .5 * data.tick/* offset */); 

LOOP_DOUBLE_WAV l;
"../_SAMPLES/dhoomtala_chill/cocotte.wav" => l.read;
0.16 * data.master_gain => l.buf.gain => l.buf2.gain;
l.AttackRelease(1::ms,  100::ms);
l.start(1::ms /* sync */ ,   4 * data.tick /* END sync */ ,  16 * data.tick /* loop */); l $ ST @=> ST @ last;   

while(1) {
       100::ms => now;
}


