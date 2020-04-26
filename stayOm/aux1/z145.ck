LOOP_WAV l;
"../../_SAMPLES/stayOm/accap/loop long.wav" => l.read;
0.5 * data.master_gain => l.buf.gain;
l.AttackRelease(1::ms, 100::ms);
l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;   


STCUTTER stcutter;
":4 1___ __1_ 11__ __1__" => stcutter.t.seq;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
