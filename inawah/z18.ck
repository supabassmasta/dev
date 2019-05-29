LONG_WAV l;
"../_SAMPLES/inawah/Inawah voices processed.wav" => l.read;
0.6 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(8 * data.tick /* sync */ , 2 * 16 * data.tick  /* offset */ , 8 * 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STHPF hpf;
hpf.connect(last $ ST , 1000 /* freq */  , 2.0 /* Q */  );       hpf $ ST @=>  last; 

//last.mono() => PitShift p => dac;
//Std.mtof(48) / Std.mtof(50) =>  p.shift;
//1.0 => p.mix;


while(1) {
       100::ms => now;
}
 
