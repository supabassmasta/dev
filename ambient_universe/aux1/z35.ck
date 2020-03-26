LONG_WAV l;
"../../_SAMPLES/ambient_universe/ambraw1.wav" => l.read;
1.05 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(10::ms, 4000::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STDELAY stdelay;
stdelay.connect(last $ ST , data.tick * 2. / 4. /* static delay */ );       stdelay $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 2 / 4 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STAUTOPAN autopan2;
autopan2.connect(l $ ST, .6 /* span 0..1 */, data.tick * 3 / 4 /* period */, 0.95 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(autopan $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
