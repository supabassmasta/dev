LOOP_DOUBLE_WAV l;
"./arpconv.wav" => l.read;
3.0 * data.master_gain => l.buf.gain => l.buf2.gain;
l.AttackRelease(180::ms, 15 * 100::ms);
l.start(4 * data.tick /* sync */ ,   1 * data.tick /* END sync */ ,  32 * data.tick /* loop */); l $ ST @=> ST @ last;   

STLPFC lpfc;
lpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lpfc $ ST @=>  last; 

STECHOC0 ech;
ech.connect(last $ ST , data.tick * 8 / 4 -2::ms /* period */ , HW.lpd8.potar[1][4] /* Gain */ );      ech $ ST @=>  last;   


while(1) {
       100::ms => now;
}
 
