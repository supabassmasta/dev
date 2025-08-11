<<<"GEN NOISE for Custom impulse response">>>;
5::second => dur d;
Noise n => dac;
REC rec;
////rec.rec(8*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */);
rec.rec_no_sync(d, "noise_ref.wav"); 


d + 1::ms => now;

while(1) {
       100::ms => now;
}
 

