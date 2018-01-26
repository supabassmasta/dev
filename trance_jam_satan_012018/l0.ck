FREQ_STR f0; 8 => f0.max; 2=> f0.sync;
" *4 534201 02130435 324516 47839 482905943032914752049857 " =>     f0.seq;     
f0.reg(TB303 s0);
f0.post() => Gain g => ADSR a => dac;
a.set(4000::ms, 0::ms, 1., 0::ms);

a.keyOn();
.13 => g.gain;
while(1) {  100::ms => now; }
//data.meas_size * data.tick => now;    
