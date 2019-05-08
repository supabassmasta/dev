LOOP_WAV l;
"../_SAMPLES/Chassin/something_blue/something piano.wav" => l.read;
0.25 * data.master_gain => l.buf.gain;
l.AttackRelease(1::ms, 100::ms);
l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;   

//LONG_WAV l;
//"../_SAMPLES/Chassin/something_blue/something piano.wav" => l.read;
//0.4 * data.master_gain => l.buf.gain;
//0 => l.update_ref_time;
//l.AttackRelease(0::ms, 0::ms);
//l.start(8 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 8 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

//STECHOC0 ech;
//ech.connect(last $ ST , data.tick * 1 / 4  /* period */ , HW.lpd8.potar[1][4] /* Gain */ );      ech $ ST @=>  last;   

STECHOC0 ech2;
ech2.connect(l $ ST , data.tick * 1 / 4  /* period */ , HW.lpd8.potar[1][4] /* Gain */ );      ech2 $ ST @=>  last;   

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, 1*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
