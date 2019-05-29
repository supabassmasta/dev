LONG_WAV l;
"../_SAMPLES/inawah/the hopi way processed2.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(100::ms /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  


//last.mono() => PitShift p => dac;
//Std.mtof(48) / Std.mtof(50) =>  p.shift;
//1.0 => p.mix;

10::second => now;

LONG_WAV l2;
"../_SAMPLES/rattlesnake/rattlesnake6.wav" => l2.read;
0.7 * data.master_gain => l2.buf.gain;
0 => l2.update_ref_time;
l2.AttackRelease(0::ms, 0::ms);
l2.start(100::ms /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l2 $ ST @=>  last;  

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 , .6);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
