
12*data.tick => now;
//SYNC sy;
//sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , -11 * data.tick); 

LONG_WAV l;
"../_SAMPLES/Horse/horse_gallop_then_whinny.wav" => l.read;
1.2 => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 12 * data.tick  + 200::ms /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l $ ST @=> ST @ last;  


while(1) {
	     100::ms => now;
}
 

