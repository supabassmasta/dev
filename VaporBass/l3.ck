SEQ_STR s0; // 4 => s0.max; 0 => s0.sync;

s0.reg(0, "../_SAMPLES/amen_kick.wav");
s0.reg(1, "../_SAMPLES/amen_snare.wav");
s0.reg(2, "../_SAMPLES/amen_snare2.wav");
s0.reg(3, "../_SAMPLES/amen_hit.wav");
//s0.reg("A", "../_SAMPLES/REGGAE_SET_1/Timbales1_Reaggae1.wav");

"*4 5_5_e_5_" => s0.seq; 
"*4 __55e5__" => s0.seq; 
"*4 __5_e__5" => s0.seq; 
"*4 5___e___" => s0.seq; 
1 => s0.sync;
s0.post() => Gain g => dac;
.3 => g.gain;

s0.go();
while(1) { 100::ms => now; }
