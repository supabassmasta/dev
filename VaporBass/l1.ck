SEQ_STR s0; // 4 => s0.max;
1 => s0.sync;

s0.reg(0, "../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Kicks/Wal_K.wav");
s0.reg(1, "../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Snares/Wsc_Snr2.wav");
s0.reg(2, "../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Hi-Hats/Str_H1.wav");
s0.reg(3, "../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Percussions/Bngo_3.wav");
//s0.reg("A", "../_SAMPLES/REGGAE_SET_1/Timbales1_Reaggae1.wav");

"*4 6_C_ 5|e_CC " => s0.seq; //s0.post() =>  dac;
"*4 6_C_ 5|e_rC " => s0.seq; //s0.post() =>  dac;
"*4 6_C_ 5|e_C6 " => s0.seq; //s0.post() =>  dac;
"*4 __C_ 5|e6CC " => s0.seq; //s0.post() =>  dac;

s0.go();
while(1) { 100::ms => now; }
//data.meas_size * data.tick => now; 
