class synt0 extends SYNT{

    8 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    Step det_amount[synt_nb];
    SinOsc s[synt_nb];
    Gain final => outlet; .3 => final.gain;

    inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  4.51 => det_amount[i].next;      .1 => s[i].gain; i++;  


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

lpk25 l;
POLY synta; 
l.reg(synta);
synta.reg(synt0 s0);  synta.a[0].set(300::ms, 100::ms, .7, 2000::ms);
synta.reg(synt0 s1);  synta.a[1].set(300::ms, 100::ms, .7, 2000::ms);
synta.reg(synt0 s2);  synta.a[2].set(300::ms, 100::ms, .7, 2000::ms);
synta.reg(synt0 s3);  synta.a[3].set(300::ms, 100::ms, .7, 2000::ms);

// Note info duration
10 * 100::ms => synta.ni.d;

synta $ ST @=> ST @ last; 

//STLHPFC2 lhpfc2;
//lhpfc2.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc2 $ ST @=>  last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STMIX stmix;
stmix.send(last, 58);

while(1) {
       100::ms => now;
}
 
