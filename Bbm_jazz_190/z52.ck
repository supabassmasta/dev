STADC1 stadc1; stadc1 $ ST @=>  ST @ last;  

STSAMPLERC stsamplerc;
stsamplerc.connect(last $ ST,  "./" /*wav path*/, "sample" /*name NoEXT°*/, 16 * data.tick /* sync_dur,0==full dur */, 0*data.tick /*0=end with rec button*/, 1/*loop playback*/, 0/*nosync*/, me.path()); stsamplerc $ ST @=>  last;   

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 14/* ir index */, 1 /* chans */, 18::ms /* pre delay*/, .06 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
