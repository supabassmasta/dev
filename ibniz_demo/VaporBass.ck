SndBuf s => dac;
"VaporBass.wav" => s.read;

while(1) {
	s.length() => now;
	0=> s.pos;
}
 
