125 => data.bpm;   (60.0/data.bpm)::second => data.tick;
55 => data.ref_note;

LONG_WAV l;
"/home/toup/Zik/2020/saz_dub/saz_dub.wav" => l.read;
0.6 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 300::ms);
l.start(1::ms /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
