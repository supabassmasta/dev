ST st;
adc => st.mono_in;

STGAINC gainc;
gainc.connect(st , HW.lpd8.potar[1][4] /* gain */  , 0.3 /* static gain */  );       gainc $ ST @=>  ST @ last; 

STREVAUX strevaux;
strevaux.connect(last $ ST, 1. /* mix */); strevaux $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 

