STADC1 stadc1; stadc1 $ ST @=>  ST @ last;  

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 24/* ir index */, 2 /* chans */, 0::ms /* pre delay*/, .1 /* rev gain */  , 0. /* dry gain */  );       stconvrev $ ST @=>  last;  
while(1) {
       100::ms => now;
}
 
