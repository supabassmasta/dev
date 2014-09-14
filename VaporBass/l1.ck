SEQ_STR s0; // 4 => s0.max;
2 => s0.sync;

s0.reg(0, "../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Kicks/Wal_K.wav");
//s0.reg("A", "../_SAMPLES/REGGAE_SET_1/Timbales1_Reaggae1.wav");

"4" => s0.seq; //s0.post() =>  dac;

s0.go();
while(1) { 100::ms => now; }
//data.meas_size * data.tick => now; 
