NOREPLACE no;

SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(32 * data.tick , -17 * data.tick /* offset */); 

LONG_WAV l;
"../_SAMPLES/Aborigines/abo0 by warpman.wav" => l.read;
0.28 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

15 * data.tick => now;

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .7);  ech $ ST @=>  last; 

1 * data.tick => now;
l.stop();

while(1) {
       100::ms => now;
}
 
