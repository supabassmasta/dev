LONG_WAV l;
"../_SAMPLES/Satan/4 sitar-1.wav" => l.read;
3.0 => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(2::ms, 2::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 64 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

//STGAINC gainc;
//gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 


while(1) {
	     100::ms => now;
}
 
