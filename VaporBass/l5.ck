
FREQ_STR f0; 8 => f0.max; 1=> f0.sync;
">6 *8 00__ 0__1 0_2_ 0_1_ __4_ 0_1_ 0_2_ 0_1_ " =>     f0.seq;     
">6 *8 00__ 0__1 4___ 3_1_   0101  0101  0202  0304 " =>     f0.seq;     
f0.reg(CHILL s0);
//f0.post()  => dac;

while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
