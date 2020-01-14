//2000::ms => now;
<<<"go">>>;
seqSndBuf s => Gain g=> dac;
.2=>g.gain;
"../_SAMPLES/Dubstep_Drum_Kit/Dubstep Kick 2.wav"=> s.read;
 s.rel_dur << 2.  ;
 s.g       << 1.2  ;
 190 => s.bpm;
 s.go();

// seqSndBuf s2 => g;
// 1=>s2.gain;
// "../_SAMPLES/Dubstep_Drum_Kit/Dubstep Snare 1.wav"=> s2.read;
 // s2.rel_dur << 2. << 2. ;
 // s2.g       << 0. << 1. ;
 // 190 => s2.bpm;

while(1) 1000::ms=>now;