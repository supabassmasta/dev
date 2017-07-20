SndBuf buf => blackhole;
"../_SAMPLES/HIHAT_02.WAV" => buf.read;
.2 => buf.gain;
//buf.samples() => buf.pos;
0 => buf.pos;
<<<buf.length()/1::ms>>>;
10::ms => now;
100./110. => buf.rate;
<<<buf.length()/1::ms>>>;

1::ms => now;
