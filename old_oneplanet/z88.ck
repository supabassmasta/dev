class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      3.5 => s.gain;
      .1 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

lpk25 l;
GLIDE synta; 20::ms => synta.duration;  300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
l.reg(synta);
synta.reg(synt0 s0); synta $ ST @=> ST @ last; 


STWPDiodeLadder stdl;
stdl.connect(last $ ST , 1000 /* cutoff */  , 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 


//STSYNCWPDiodeLadder stsyncdl;
//stsyncdl.freq(3*100 /* Base */, 5 * 100 /* Variable */, 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */ );
//stsyncdl.adsr_set(.1 /* Relative Attack */, .7/* Relative Decay */, 0.00001 /* Sustain */, .0 /* Relative Sustain dur */, 0.0 /* Relative release */);
//stsyncdl.connect(t $ ST, t.note_info_tx_o); stsyncdl $ ST @=>  last;  



while(1) {
       100::ms => now;
}
 
