class synt0 extends SYNT{

    8 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    TriOsc s[synt_nb];
    Gain final => outlet; .5 => final.gain;
    .1 => float w;

    inlet => detune[i] => s[i] => final; w => s[i].width;   1. => detune[i].gain;    .6 => s[i].gain; i++;  
//    inlet => detune[i] => s[i] => final; w => s[i].width;   0.0001 => detune[i].gain;    .3 => s[i].gain; i++;  
//    inlet => detune[i] => s[i] => final; w => s[i].width;   .99985 => detune[i].gain;    .2 => s[i].gain; i++;  


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

lpk25 l;
POLY synta; 
l.reg(synta);
synta.reg(synt0 s0);  synta.a[0].set(3::ms, 30::ms, .7, 100::ms);
synta.reg(synt0 s1);  synta.a[1].set(3::ms, 30::ms, .7, 100::ms);
synta.reg(synt0 s2);  synta.a[2].set(3::ms, 30::ms, .7, 100::ms);
synta.reg(synt0 s3);  synta.a[3].set(3::ms, 30::ms, .7, 100::ms);

// Note info duration
10 * 100::ms => synta.ni.d;

synta $ ST @=> ST @ last; 

//STLHPFC2 lhpfc2;
//lhpfc2.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc2 $ ST @=>  last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

//STMIX stmix;
//stmix.send(last, 58);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 
