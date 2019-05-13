LOOP_DOUBLE_WAV l;
"../_SAMPLES/inawah/high_space_pads.wav" => l.read;
1.0 * data.master_gain => l.buf.gain => l.buf2.gain;
l.AttackRelease(100::ms, 15 * 100::ms);
l.start(8 * data.tick /* sync */ ,   1 * data.tick /* END sync */ ,  8 * data.tick /* loop */); l $ ST @=> ST @ last;   

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, 3*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STADSRC stadsrc;
stadsrc.connect(last, HW.launchpad.keys[16*7 + 3] /* pad 1:1 */ /* controler */, 100::ms /* attack */, 1000::ms /* release */, 0 /* default_on */, 1  /* toggle */); stadsrc $ ST @=> last; 

while(1) {
       100::ms => now;
}
 

