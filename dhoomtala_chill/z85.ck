//SYNC sy;
//sy.sync(4 * data.tick);
////sy.sync(4 * data.tick , .5 * data.tick/* offset */); 

LOOP_DOUBLE_WAV l;
"../_SAMPLES/dhoomtala_chill/cocotte.wav" => l.read;
0.16 * data.master_gain => l.buf.gain => l.buf2.gain;
l.AttackRelease(1::ms,  100::ms);
l.start(4 * data.tick /* sync */ ,   4 * data.tick /* END sync */ ,  16 * data.tick /* loop */); l $ ST @=> ST @ last;   

STADSRC stadsrc;
stadsrc.connect(last, HW.launchpad.keys[16*6 + 4] /* pad 7:5 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 1 /* default_on */, 0  /* toggle */); stadsrc $ ST @=> last;

STECHOC0 ech;
ech.connect(last $ ST , data.tick * 3 / 4  /* period */ , HW.lpd8.potar[1][4] /* Gain */ );      ech $ ST @=>  last;   



while(1) {
       100::ms => now;
}


