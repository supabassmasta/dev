REC rec;
rec.rec(8*data.tick, "test2.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */);
//rec.rec_no_sync(8*data.tick, "test.wav"); 

while(1) {
       100::ms => now;
}
 
