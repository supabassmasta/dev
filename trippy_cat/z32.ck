LONG_WAV l;
"../_SAMPLES/trippy_cat/niap_maj.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STADSRC stadsrc;
stadsrc.connect(last, HW.launchpad.keys[16*2 + 2] /* pad 3:3 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 1 /* default_on */, 0  /* toggle */); stadsrc $ ST @=> last;

//////////////////////////////////////
// ECHO SECTION
///////////////////////////////////
STADSRC stadsrc2;
stadsrc2.connect(l, HW.launchpad.keys[16*2 + 2] /* pad 3:3 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 0 /* default_on */, 0  /* toggle */); // stadsrc2 $ ST @=> last;

STECHO ech2;
ech2.connect(stadsrc2 $ ST , data.tick * 3/ 4 , .7); 

STAUTOPAN autopan2;
autopan2.connect(ech2 $ ST, -.4 /* span 0..1 */, 8*data.tick /* period */, 0.5 /* phase 0..1 */ );  


while(1) {
       100::ms => now;
}
 
