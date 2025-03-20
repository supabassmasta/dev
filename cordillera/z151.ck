STADC1 stadc1; stadc1 $ ST @=>  ST @ last; 


STSAMPLERC stsamplerc;
stsamplerc.connect(last $ ST,  "./" /*wav path*/, "sample" /*name NoEXT°*/, 4 * data.tick /* sync_dur,0==full dur */, 0*data.tick /*0=end with rec button*/, 1/*loop playback*/, 0/*nosync*/, 186::ms /*latency*/, me.path()); stsamplerc $ ST @=>  last;  
//LATENCY(ms):ctopp:334,internal card:188,Scarlett:390 

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 8/* ir index */, 1 /* chans */, 0::ms /* pre delay*/, .1 /* rev gain */  , 1.0 /* dry gain */  );       stconvrev $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
