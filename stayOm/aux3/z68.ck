LONG_WAV l;
"../../_SAMPLES/stayOm/saz_loop.wav" => l.read;
0.58 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(16 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 16 * 16 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STEQ steq;
steq.static_connect(last $ ST,  152.010417  /* HPF freq */,  1.000000  /* HPF Q */,  7811.369083  /* LPF freq */,  8.375000  /* LPF Q */
      ,  10071.747364  /* BRF1 freq */,  1.000000  /* BRF1 Q */,  279.000000  /* BRF2 freq */,  4.000000  /* BRF2 Q */
      ,  2489.015870  /* BPF1 freq */,  5.000000  /* BPF1 Q */,  1.937500  /* BPF1 Gain */
      ,  0.000000  /* BPF2 freq */,  1.000000  /* BPF2 Q */,  0.000000   /* BPF2 Gain */
      ,  1.000000  /* Output Gain */ ); steq $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.1 /* early */ , 0.3 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
