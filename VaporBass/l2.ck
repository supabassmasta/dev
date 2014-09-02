
FREQ_STR f0; //8 => f0.max; 1=> f0.sync;
"<c 0" =>     f0.seq;     
f0.reg(SUPERSAW s0);
//f0.post()  => dac;

while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
