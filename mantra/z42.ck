LOOP_WAV l;
"../_SAMPLES/mantra/Dub Percs 1 BPM126_80_adjusted.wav" => l.read;
0.3 * data.master_gain => l.buf.gain;
l.AttackRelease(1::ms, 100::ms);

8 * data.tick => l.the_end.fixed_end_dur;  

l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;   
STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
