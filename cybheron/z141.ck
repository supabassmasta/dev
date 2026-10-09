LONG_WAV l;
//"../_SAMPLES/aliens/alientheory.wav" => l.read;
"../_SAMPLES/aliens/alient2.wav" => l.read;
1.2 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 12/* ir index */, 1 /* chans */, 15::ms /* pre delay*/, .12 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  



while(1) {
       100::ms => now;
}
 
