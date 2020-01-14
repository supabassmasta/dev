// 3::second => now;
seqSndBuf s2 =>Gain g=> dac;
.2=>g.gain;
// 1=>s2.gain;
"../../examples/data/snare-hop.wav"=> s2.read;
 s2.rel_dur << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5  ;
 s2.g       << .0 << .0 << .0 << .9      << .0 << .0 << .9 << .0    ;
 //s2.r       << 0. << 1. << 0. << 0.8  ;
 190 => s2.bpm;
 // 0 => s2.sync_on;
 s2.go();



while(1) 1000::ms=>now;