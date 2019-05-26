class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
      .12 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

lpk25 l;
GLIDE synta; 60::ms => synta.duration;  300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
l.reg(synta);
synta.reg(synt0 s0); 
synta $ ST @=> ST @ last;

STWPDiodeLadder stdl;
stdl.connect(last $ ST , 1000 /* cutoff */  , 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 1 * 100 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STCOMPRESSOR stcomp;
6. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   

STGAIN stgain;
stgain.connect(last $ ST , 5. /* static gain */  );       stgain $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
