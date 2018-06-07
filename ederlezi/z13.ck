LONG_WAV l;
"../_SAMPLES/Horse/horse_gallop_then_whinny.wav" => l.read;
0.8 => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(1 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STLPFC lpfc;
lpfc.connect(last $ ST , HW.lpd8.potar[1][7] /* freq */  , HW.lpd8.potar[1][8] /* Q */  );       lpfc $ ST @=>  last; 

while(1) {
	     100::ms => now;
}


