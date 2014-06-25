SEQ_STR s0; // 4 => s0.max; 0 => s0.sync;

//s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_1.wav");
//s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_10.wav");
//s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_11.wav");
//s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_12.wav");
//s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_13.wav");
//s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_2.wav");
//s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_3.wav");
//s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_4.wav");
s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_5.wav");
//s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_6.wav");
//s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_7.wav");
//s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_8.wav");
//s0.reg(0, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Kick_9.wav");



//s0.reg(1, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_1.wav");
//s0.reg(1, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_10.wav");
//s0.reg(1, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_11.wav");
//s0.reg(1, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_2.wav");
//s0.reg(1, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_3.wav");
//s0.reg(1, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_4.wav");
s0.reg(1, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_5.wav");
//s0.reg(1, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_6.wav");
//s0.reg(1, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_7.wav");
//s0.reg(1, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_8.wav");
//s0.reg(1, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Snare_9.wav");



//s0.reg(2, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_1.wav");
//s0.reg(2, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_2.wav");
s0.reg(2, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_3.wav");
//s0.reg(2, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_4.wav");
//s0.reg(2, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_5.wav");
//s0.reg(2, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_6.wav");
//s0.reg(2, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_7.wav");
//s0.reg(2, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Hat_8.wav");


//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_1.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_2.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_3.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_4.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_5.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_6.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Crash_7.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_1.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_10.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_11.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_2.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_3.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_4.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_5.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_6.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_7.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_8.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Effect_9.wav");
s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Tom_1.wav");
//s0.reg(3, "../_SAMPLES/Dubstep_Drum_Kit/Dubstep_Tom_2.wav");



" *4 p|6|C_C_d|C_C6  6|C_6|C_d|C_Cd " => s0.seq; //s0.post() =>  dac;

s0.go();
while(1) { 100::ms => now; }
//data.meas_size * data.tick => now; 
