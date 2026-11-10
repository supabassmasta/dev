class synt0 extends SYNT{

		inlet => TriOsc s =>  outlet;		
				.5 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 


//lpk25 l;
//GLIDE synta; 20::ms => synta.duration;	300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
//l.reg(synta);
//synta.reg(synt0 s0); 

lpk25 l;
GLIDE synta; 32::ms => synta.duration;  300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
l.reg(synta);
synta.reg(SERUM00 s0);
s0.config(249 /* synt nb */ ); 

// Note info duration
10 * 100::ms => synta.ni.d;

synta $ ST @=> ST @ last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(100 /* Base */, 2 * 100 /* Variable */, 1. /* Q */);
stsynclpfx0.adsr_set(.1 /* Relative Attack */, .6/* Relative Decay */, 0.4 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, synta.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

s0.inlet => stsynclpfx0.nio.base;

//STDISTO stdisto;
//stdisto.connect(last $ ST,3/*mode*/,3.0/*gain in*/,0/*dc blcok*/,1/*chan*/,0.1/*gain*/);       stdisto $ ST @=>  last;  
//.45 => stdisto.distl.bias=> stdisto.distr.bias;
//1.8 =>  stdisto.distl.warmth=>  stdisto.distr.warmth;

//STCONVREV stconvrev;
//stconvrev.connect(last $ ST , 35/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .1 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  




while(1) {
	     100::ms => now;
}
 
