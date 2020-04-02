class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
Step det_amount[synt_nb];
SERUM0 s[synt_nb];
Gain final => outlet; .3 => final.gain;

48 =>int  nb;
0 => int rk;

inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  -4.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  4.51 => det_amount[i].next;      .1 => s[i].gain; i++;   

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

lpk25 l;
POLY synta; 
l.reg(synta);
synta.reg(synt0 s0);  synta.a[0].set(300::ms, 300::ms, .7, 2000::ms);
synta.reg(synt0 s1);  synta.a[1].set(300::ms, 300::ms, .7, 2000::ms);
synta.reg(synt0 s2);  synta.a[2].set(300::ms, 300::ms, .7, 2000::ms);
synta.reg(synt0 s3);  synta.a[3].set(300::ms, 300::ms, .7, 2000::ms);

// Note info duration
20 * 100::ms => synta.ni.d;

synta $ ST @=> ST @ last; 


STSYNCLPF2 stsynclpf2;
stsynclpf2.freq(40 *10 /* Base */, 50 * 100 /* Variable */, 2.0 /* Q */);
stsynclpf2.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf2.connect(last $ ST, synta.note_info_tx_o); stsynclpf2 $ ST @=>  last; 


//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 4. /* static gain */  );       gainc $ ST @=>  last; 


STMIX stmix;
stmix.send(last, 58);
//stmix.receive(11); stmix $ ST @=> ST @ last; 
while(1) {
       100::ms => now;
}
 
