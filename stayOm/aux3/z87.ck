LONG_WAV l;
"/home/toup/EC/StayOm/ConfitmontageSatan1.wav" => l.read;
0.3 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(16 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
