REC rec;

/////////////////////////
// TRANCE
/////////////////////////


HW.launchpad.virtual_key_on_only(44);
HW.launchpad.virtual_key_on_only(45);
HW.launchpad.virtual_key_on_only(46);

1::data.tick => now;

rec.rec(32*data.tick, "../_SAMPLES/oneplanet/trance_synts_and_bells.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */); 

HW.launchpad.virtual_key_off_only(44);
HW.launchpad.virtual_key_off_only(45);
HW.launchpad.virtual_key_off_only(46);

16::data.tick => now;

HW.launchpad.virtual_key_on_only(41);
HW.launchpad.virtual_key_on_only(42);
HW.launchpad.virtual_key_on_only(43);


rec.rec(32*data.tick, "../_SAMPLES/oneplanet/trance_synts_2.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */); 
HW.launchpad.virtual_key_off_only(41);
HW.launchpad.virtual_key_off_only(42);
HW.launchpad.virtual_key_off_only(43);

31::data.tick => now;
HW.launchpad.virtual_key_on_only(54);

rec.rec(32*data.tick, "../_SAMPLES/oneplanet/trance_scratchs_1.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */); 
HW.launchpad.virtual_key_off_only(54);

31::data.tick => now;
HW.launchpad.virtual_key_on_only(61);
rec.rec(32*data.tick, "../_SAMPLES/oneplanet/trance_scratchs_2.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */); 
HW.launchpad.virtual_key_off_only(61);

/////////////////////////
// CHILL
/////////////////////////

16::data.tick => now;
HW.launchpad.virtual_key_on_only(32);
HW.launchpad.virtual_key_on_only(35);
HW.launchpad.virtual_key_on_only(36);
rec.rec(32*data.tick, "../_SAMPLES/oneplanet/beat_chill.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */); 
HW.launchpad.virtual_key_off_only(32);
HW.launchpad.virtual_key_off_only(35);
HW.launchpad.virtual_key_off_only(36);

16::data.tick => now;

HW.launchpad.virtual_key_on_only(38);
HW.launchpad.virtual_key_on_only(48);
rec.rec(32*data.tick, "../_SAMPLES/oneplanet/loop_pads.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */); 
HW.launchpad.virtual_key_off_only(38);
HW.launchpad.virtual_key_off_only(48);

16::data.tick => now;

HW.launchpad.virtual_key_on_only(58);
HW.launchpad.virtual_key_on_only(68);
rec.rec(32*data.tick, "../_SAMPLES/oneplanet/loop_pans.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */); 
HW.launchpad.virtual_key_off_only(58);
HW.launchpad.virtual_key_off_only(68);

100::ms => now;
