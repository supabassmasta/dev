
REC rec;
//rec.rec(16*data.tick, "../_SAMPLES/inawah/pads.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */); 
//rec.rec(16*data.tick, "../_SAMPLES/inawah/high_space_pads.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */); 
rec.rec(16*data.tick, "../_SAMPLES/inawah/space_pads.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */); 

while(1) {
	     100::ms => now;
}
 
