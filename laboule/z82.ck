LONG_WAV l;
"../_SAMPLES/la boule/la boule loop1.wav" => l.read;
0.4 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 10::ms);
l.start(16 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 16 * data.tick /* loop (0::ms == disable) */ , 16 * data.tick /* END sync */); l $ ST @=> ST @ last;  

//STADSRC stadsrc;
//stadsrc.connect(last, HW.launchpad.keys[16*6 + 7] /* pad 1:1 */ /* controler */, 10::ms /* attack */, 10::ms /* release */, 1 /* default_on */, 0  /* toggle */); stadsrc $ ST @=> last; 

STADSR stadsr;
stadsr.set(10::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 100::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 

MASTER_STADSR.reg(stadsr, 0);

while(1) {
       100::ms => now;
}
 
