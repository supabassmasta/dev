
ST st;

adc =>  st.mono_in;
st @=> ST @ last;

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 9/* ir index */, 2 /* chans */, 10::ms /* pre delay*/, .2 /* rev gain */  , 0.0 /* dry gain */  );       stconvrev $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
