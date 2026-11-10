class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.5 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 


//lpk25 l;
//GLIDE synta; 20::ms => synta.duration;	300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
//l.reg(synta);
//synta.reg(synt0 s0); 

lpk25 l;
GLIDE synta; 20::ms => synta.duration;  300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
l.reg(synta);
synta.reg(synt0 s0);

// Note info duration
10 * 100::ms => synta.ni.d;

synta $ ST @=> ST @ last; 


STDISTO stdisto;
stdisto.connect(last $ ST,3/*mode*/,3.0/*gain in*/,0/*dc blcok*/,1/*chan*/,0.1/*gain*/);       stdisto $ ST @=>  last;  
.45 => stdisto.distl.bias=> stdisto.distr.bias;
1.8 =>  stdisto.distl.warmth=>  stdisto.distr.warmth;

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 35/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .1 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  




while(1) {
	     100::ms => now;
}
 
