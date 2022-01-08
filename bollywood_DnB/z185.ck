LONG_WAV l;
"/home/toup/EC/STUDIO Bondlywood/Mission BondlywoodSitar AKG.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(1 * data.tick /* sync */ ,(60 * 2 + 0 )::second  /* offset */ , 30::second , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  


while(1) {
       100::ms => now;
}
