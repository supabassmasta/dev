REC rec;
rec.rec(8.7::minute , "/home/toup/EC/StayOm/rec_glitchs/rec2.wav", 4 * data.tick /* sync_dur, 0 == sync on full dur */);
//rec.rec_no_sync(8*data.tick, "test.wav"); 

while(1) {
       100::ms => now;
}

