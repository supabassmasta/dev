SYNC sy;
sy.sync(8 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 
SndBuf l;
"../_SAMPLES/quasar/slide_bass.wav" => l.read;
-1. => l.rate;
l.samples() => l.pos;

l => dac;

while(1) {
       100::ms => now;
}
 
