10::second => dur d;

REC rec;
rec.rec(d, "test.wav", 1::ms /* sync_dur, 0 == sync on full dur */);
//rec.rec_no_sync(8*data.tick, "test.wav"); 

d => now;

