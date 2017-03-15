REC rec;
rec.rec(32*data.tick, "test.wav", 8 * data.tick /* sync_dur, 0 == sync on full dur */); 

while(1) {
       100::ms => now;
}
 
