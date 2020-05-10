LONG_WAV l;
"../../_SAMPLES/oud/oilvoud162SolRe.wav" => l.read;
0.3 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 4 * 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  


STCUTTER stcutter;
"____ __11" => stcutter.t.seq;  32*  data.tick=> stcutter.t.the_end.fixed_end_dur;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

 
 STECHO ech;
 ech.connect(last $ ST , data.tick * 6 / 4 , .8);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
 
