
class synt0 extends SYNT{

  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  Step det_amount[synt_nb];
  SERUM0 s[synt_nb];
  Gain final => outlet; .8 => final.gain;
  
  4 => int nb;
  0 => int rk;

  inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  0 => det_amount[i].next;      .9 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  8 => det_amount[i].next;      .1 => s[i].gain; i++;  
//  inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
}


lpk25 l;
GLIDE synta; 8::ms => synta.duration;  300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
l.reg(synta);
synta.reg(synt0 s0); 

// Note info duration
4 * data.tick => synta.ni.d;

synta $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 3 * 100 /* Variable */, 1. /* Q */);
stsynclpf.adsr_set(.1 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .8 /* Relative Sustain dur */, 0.2 /* Relative release */);
stsynclpf.connect(last $ ST, synta.note_info_tx_o); stsynclpf $ ST @=>  last; 


    while(1) {
           100::ms => now;
    }
     

