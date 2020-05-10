REC rec;

20 * 60 * 1000::ms => dur d;

///////////////////////////////////////////////////////////////////////////////////

100 => data.bpm;   (60.0/data.bpm)::second => data.tick;

LAUNCHPAD_VIRTUAL.on.set(111);
LAUNCHPAD_VIRTUAL.on.set(121);

rec.rec(d, "../_SAMPLES/tanpura/new_loops/kehr_vaa_" + data.bpm $ int + "_F.wav", 16 * data.tick /* sync_dur, 0 == sync on full dur */);
//rec.rec_no_sync(8*data.tick, "test.wav"); 

LAUNCHPAD_VIRTUAL.off.set(111);
LAUNCHPAD_VIRTUAL.off.set(121);

16 * data.tick => now;


