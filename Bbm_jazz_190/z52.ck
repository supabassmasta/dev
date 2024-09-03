STADC1 stadc1; stadc1 $ ST @=>  ST @ last;  

STSAMPLERC stsamplerc;
stsamplerc.connect(last $ ST,  "./" /* path for wav */,  "sample" /* wav name, /!\ NO EXTENSION */, 4 * data.tick /* sync_dur, 0 == sync on full dur */, 0*data.tick /*if 0, end with rec button*/, 1 /*loop playback*/, 0 /* no sync */ ); stsamplerc $ ST @=>  last;   

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 14/* ir index */, 1 /* chans */, 18::ms /* pre delay*/, .06 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
