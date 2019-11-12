
REC rec;
//rec.rec(64*data.tick, "../_SAMPLES/quasar/theme0.wav", 16 * data.tick /* sync_dur, 0 == sync on full dur */); 
//rec.rec(16*data.tick, "../_SAMPLES/quasar/niap_dub.wav", 16 * data.tick /* sync_dur, 0 == sync on full dur */); 
//rec.rec(16*data.tick, "../_SAMPLES/quasar/bass_dub.wav", 16 * data.tick /* sync_dur, 0 == sync on full dur */); 
rec.rec(64*data.tick, "../../../quasar_dub_part.wav", 4 * data.tick /* sync_dur, 0 == sync on full dur */); 

while(1) {
	     100::ms => now;
}
 
