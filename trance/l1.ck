SEQ s;

SET_WAV.DUBSTEP(s);
s.element_sync();
"*2+++k---h k-----|s h" => s.seq;
s.go();


FREQ_STR f0; 4 => f0.max; 1=> f0.sync;
"<c<c *4 _0|00" =>     f0.seq;     
f0.reg(TB303 s0);
f0.post() => Gain g  => dac;
.4 => g.gain;
while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
