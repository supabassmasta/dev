LONG_WAV l;
"../_SAMPLES/sakura/intro.wav" => l.read;
1.1 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

// BASS Start
l.start(1::samp /* sync */ , 0  * data.tick  /* offset */ ,  0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  



// BASS cut
//STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//sthpfx0.connect(last $ ST ,  sthpfx0_fact, 350.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 2 /* channels */ );       sthpfx0 $ ST @=>  last;  

 //  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
 //  stlpfx0.connect(l $ ST ,  stlpfx0_fact, 362.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 2 /* channels */ );       stlpfx0 $ ST @=>  last;  
 //  
 //  STDUCK duck;
 //  duck.connect(last $ ST);      duck $ ST @=>  last; 

15.37::second => now;

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

data.tick * 3 / 4 => now;
STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 3 / 4 /* period */, 0.5 /* phase 0..1 */ );       autopan $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
