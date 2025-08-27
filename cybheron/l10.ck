REC rec;
rec.rec(16*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */);
//rec.rec_no_sync(8*data.tick, "test.wav"); 

while(1) {
       100::ms => now;
}
 
