LONG_WAV l;
"../_SAMPLES/japan_trance/japan trance drumout.wav" => l.read;
0.8 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

l.start(1::ms /* sync */ , (5 * 32 + 16 ) * data.tick  /* offset */ ,  1 *32 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  



// BASS cut
STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
sthpfx0.connect(last $ ST ,  sthpfx0_fact, 350.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 2 /* channels */ );       sthpfx0 $ ST @=>  last;  

 //  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
 //  stlpfx0.connect(l $ ST ,  stlpfx0_fact, 362.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 2 /* channels */ );       stlpfx0 $ ST @=>  last;  
 //  
 //  STDUCK duck;
 //  duck.connect(last $ ST);      duck $ ST @=>  last; 

4 *data.tick => now;

STAUTOPAN autopan;
autopan.connect(last $ ST, .5 /* span 0..1 */, data.tick * 1 / 1 /* period */, 0.0 /* phase 0..1 */ );       autopan $ ST @=>  last; 


STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .9);  ech $ ST @=>  last; 




2 *data.tick => now;
STCUTTER stcutter;
"*8 1_1_" => stcutter.t.seq;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

2 *data.tick => now;

l.stop();



32 *data.tick => now;


 
