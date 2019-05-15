seqSndBuf s2 =>Gain g=> global_mixer.line3;
.2=>g.gain;
1=>s2.gain;
"../_SAMPLES/REGGAE_SET_1/Hi-Hat_Closed3_Reaggae1.wav"=> s2.read;
s2.rel_dur  << 1; 
s2.g         << .2  << .4  << .2   << .4   << .2  << .5  << .2 << .4;
//s2.r        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.  ;
data.bpm => s2.bpm;
0 => s2.sync_on;
s2.go();

seqSndBuf s3 =>g;
.2=>g.gain;
1=>s3.gain;
"../_SAMPLES/REGGAE_SET_2/HH_ClosedVelo04_Reggae1.wav"=> s3.read;
s3.rel_dur  << .25;
s3.g        << .0 << .0 << .0 << .0   ; 
//s3.r        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.  ;
data.bpm => s3.bpm;
0 => s3.sync_on;
s3.go();

seqSndBuf s4 =>g;
.2=>g.gain;
1=>s4.gain;
"../_SAMPLES/KICKS/KICK___11_.wav"=> s4.read;
s4.rel_dur << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5 << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5 ;
s4.g       << .5 << .0 << .0 << .0      << .0 << .0 << .0 << .5 << .5 << .0 << .0 << .0      << .0 << .0 << .0 << .0 ; 
s4.rel_dur << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5 << .5 << .5 << .5 << .5      << .5 << .5 << .5 << .5 ;
s4.g       << .5 << .0 << .0 << .0      << .0 << .0 << .0 << .5 << .5 << .0 << .0 << .5      << .0 << .5 << .0 << .0 ; 
//s4.r        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.  ;
data.bpm => s4.bpm;
0 => s4.sync_on;
s4.go();

seqSndBuf s5 =>g;
.2=>g.gain;
1=>s5.gain;
//"../_SAMPLES/REGGAE_SET_1/Snare_Drum1_Reaggae1.wav"=> s5.read;
"../_SAMPLES/REGGAE_SET_2/Snare_DrumVelo08_Metal.wav"=> s5.read;
s5.rel_dur   << .5 << .5 << .5 << .5 << .5 << .5 << .5 << .5  ; 
s5.g         << .0 << .0 << .0 << .0 << .7 << .0 << .0 << .0 ; 
//s5.r        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.  ;
data.bpm => s5.bpm;
0 => s5.sync_on;
s5.go();




seqSndBuf s6 => g;
.2=>g.gain;
1=>s6.gain;
"../_SAMPLES/REGGAE_SET_1/Snare_Drum1_Reaggae1.wav"=> s6.read;
s6.rel_dur  << .5 << .5 << .5 << .5  ; 
s6.g        << .0 << .0 << .0 << .0 ; 
//s6.r        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.        << 1. << 1. << 1. << 1.      << 1. << 1. << 1. << 1.  ;
data.bpm => s6.bpm;
0 => s6.sync_on;
s6.go();
 





data.meas_size * data.tick => now;
 

  
