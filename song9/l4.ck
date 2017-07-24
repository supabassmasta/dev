SndBuf buf => dac;
//"../_SAMPLES/HIHAT_02.WAV" => buf.read;
"../_SAMPLES/Progressive-Trance-Loops---Samples/Progressive_Trance_Loops_&_Samples/Ambient&Trance_Pads&Strings/WAV_Multisamples/AnaOrch/C3.wav" => buf.read;
.1 => buf.gain;
buf.samples() => buf.pos;
100./123. => buf.rate;

while(1) {
 0 => buf.pos;
 2010::ms => now;
}
 
