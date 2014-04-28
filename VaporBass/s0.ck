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
 

class END extends end { fun void kill_me () {
				<<<"THE END">>>;		
//								1500::ms => now;		
												<<<"THE real END">>>;		
}}; END the_end; me.id() => the_end.shred_id; killer.reg(the_end);  

while(1) {
	     100::ms => now;
}
 

