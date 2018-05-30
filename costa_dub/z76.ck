lpk25 l;
GLIDE synta; 1::ms => synta.duration;	300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
l.reg(synta);
synta.reg(DUBBASS0 s0); 


synta $ ST @=> ST @ last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 3. /* static gain */  );       gainc $ ST @=>  last; 


while(1) {
	     100::ms => now;
}


