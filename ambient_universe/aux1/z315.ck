LONG_WAV l;
"../../_SAMPLES/ambient_universe/amb6.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(10::ms, 4000::ms);
l.start(32 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
