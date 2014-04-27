seqSndBuf s2 => /* PitShift pit => */ Gain g=> dac;

.2=>g.gain;
1=>s2.gain;
"vap_loop.wav"=> s2.read;
s2.rel_dur  << 32;
s2.g        << .6  ;
//s2.r        << 75./90.; 

//90./75. => pit.shift;

data.bpm => s2.bpm;
0 => s2.sync_on;
s2.go();
2 * data.meas_size * data.tick => now;
 
