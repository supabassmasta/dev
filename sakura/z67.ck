LONG_WAV l;
"../_SAMPLES/sakura/chorus.wav" => l.read;
0.6 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 30::ms);
.5 => l.outl.gain;
1.5 => l.outr.gain;

// BASS Start
l.start(4 * data.tick /* sync */ , 0  * data.tick  /* offset */ ,  64 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

//STBELL stbell0; 
//stbell0.connect(last $ ST , 6 * 100 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, 1.1 /* Gain */ );       stbell0 $ ST @=>  last;   



16 * data.tick => now;

LONG_WAV l2;
"../_SAMPLES/sakura/chorus.wav" => l2.read;
0.6 * data.master_gain => l2.buf.gain;
0 => l2.update_ref_time;
l2.AttackRelease(0::ms, 30::ms);
1.5 => l2.outl.gain;
.5 => l2.outr.gain;


// BASS Start
l2.start(4 * data.tick /* sync */ , 0  * data.tick  /* offset */ ,  64 * data.tick /* loop (0::ms == disabl2e) */ , 1 * data.tick /* END sync */); l2 $ ST @=>  last;  

//STBELL stbell1; 
//stbell1.connect(last $ ST , 9 * 100 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, 1.1 /* Gain */ );       stbell1 $ ST @=>  last;   


// BASS cut
//STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
//sthpfx0.connect(last $ ST ,  sthpfx0_fact, 350.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 2 /* channels */ );       sthpfx0 $ ST @=>  last;  

 //  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
 //  stlpfx0.connect(l $ ST ,  stlpfx0_fact, 362.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 2 /* channels */ );       stlpfx0 $ ST @=>  last;  
 //  
 //  STDUCK duck;
 //  duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
