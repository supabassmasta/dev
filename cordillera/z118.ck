
ST st;

adc => st.mono_in;
st  @=> ST @ last;  
STCONVREV stconvrev;
stconvrev.connect(last $ ST , 8/* ir index */, 1 /* chans */, 0::ms /* pre delay*/, .1 /* rev gain */  , 0.0 /* dry gain */  );       stconvrev $ ST @=>  last;  


while(1) {
       100::ms => now;
}
 
