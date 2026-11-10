STADC1 stadc1; stadc1 $ ST @=>  ST @ last;  

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 14/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .03 /* rev gain */  , 0.0 /* dry gain */  );       stconvrev $ ST @=>  last;  

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

while(1) {
       100::ms => now;
}

