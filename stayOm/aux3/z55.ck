class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
Step det_amount[synt_nb];
TriOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;    .1 => s[i].width; .7 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.51 => det_amount[i].next;.1 => s[i].width;     .1 => s[i].gain; i++;  
//inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.51 => det_amount[i].next; .1 => s[i].width;    .1 => s[i].gain; i++;   


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


lpk25 l;
GLIDE synta; 20::ms => synta.duration;  300::ms => synta.release; synta.adsr.set(3::ms, 30::ms, .7,  synta.release);
l.reg(synta);
synta.reg(synt0 s0);

// Note info duration
4 * data.tick => synta.ni.d;

synta $ ST @=> ST @ last; 

STSYNCLPF2 stsynclpf2;
stsynclpf2.freq(10*10 /* Base */, 21 * 100 /* Variable */, 1.6 /* Q */);
stsynclpf2.adsr_set(.1 /* Relative Attack */, .2/* Relative Decay */, 0.7 /* Sustain */, .4 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf2.connect(last $ ST, synta.note_info_tx_o); stsynclpf2 $ ST @=>  last; 

STLPFC lpfc;
lpfc.connect(last $ ST , HW.lpd8.potar[1][3] /* freq */  , HW.lpd8.potar[1][4] /* Q */  );       lpfc $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 4. /* static gain */  );       gainc $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
