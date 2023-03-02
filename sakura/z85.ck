LONG_WAV l;
//"../_SAMPLES/japan_trance/japan trance drumout.wav" => l.read;
"../_SAMPLES/sakura/verse2.wav" => l.read;
0.8 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);


// BASS Start
l.start(32 * data.tick /* sync */ , 0 * data.tick  /* offset */ ,  0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  



// BASS cut
STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
sthpfx0.connect(last $ ST ,  sthpfx0_fact, 350.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 2 /* channels */ );       sthpfx0 $ ST @=>  last;  

 //  STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
 //  stlpfx0.connect(l $ ST ,  stlpfx0_fact, 362.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 2 /* channels */ );       stlpfx0 $ ST @=>  last;  
 //  
 //  STDUCK duck;
 //  duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
