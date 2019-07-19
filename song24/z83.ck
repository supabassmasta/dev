class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

lpk25 l;
GLIDE synta; 20::ms => synta.duration;  300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
l.reg(synta);
synta.reg(synt0 s0);

// Note info duration
10 * 100::ms => synta.ni.d;

synta $ ST @=> ST @ last; 

STSYNCLPF2 stsynclpf2;
stsynclpf2.freq(100 /* Base */, 11 * 100 /* Variable */, 4.0 /* Q */);
stsynclpf2.adsr_set(.1 /* Relative Attack */, .1/* Relative Decay */, 0.5 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf2.connect(last $ ST, synta.note_info_tx_o); stsynclpf2 $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
