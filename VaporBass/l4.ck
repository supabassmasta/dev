SEQ_STR s0; // 4 => s0.max; 0 => s0.sync;

s0.reg(0, "../_SAMPLES/amen_kick.wav");
s0.reg(1, "../_SAMPLES/amen_snare.wav");
s0.reg(2, "../_SAMPLES/amen_snare2.wav");
s0.reg(3, "../_SAMPLES/amen_hit.wav");
//s0.reg("A", "../_SAMPLES/REGGAE_SET_1/Timbales1_Reaggae1.wav");

"*4 5__e__n_" => s0.seq;

s0.post()=> Gain inter => convolution c =>  dac;
inter => Gain direct => dac;
.4 => direct.gain;
.1 => c.gain;

for (0 => int i; i <  106     ; i++) {
1. => c.add_tap;
}
 
for (0 => int i; i <  100    ; i++) {
//Std.randf() => c.add_tap;
}
 

s0.go();
while(1) { 100::ms => now; }
//data.meas_size * data.tick => now; 
