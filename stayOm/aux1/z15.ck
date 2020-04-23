LONG_WAV l;
"../../_SAMPLES/stayOm/pads0.wav" => l.read;
1.4 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(10::ms, 4000::ms);
l.start(16 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 7 * 10. /* room size */, 4::second /* rev time */, 0.3 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
