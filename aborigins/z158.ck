NOREPLACE no;

LAUNCHPAD_VIRTUAL.on.set(51); // Intro 


REC rec;
rec.rec(32 * 32 * data.tick, "../_SAMPLES/Aborigines/Aboexport_new.wav", 1::ms /* sync_dur, 0 == sync on full dur */);
//rec.rec_no_sync(8*data.tick, "test.wav"); 

while(1) {
       100::ms => now;
}
 
