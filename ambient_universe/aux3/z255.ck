//ST st; st @=> ST @ last;

SndBuf2 mod => blackhole;

//mod.chan(0) => st.outl;
//mod.chan(1) => st.outr;

"../_SAMPLES/CostaRica/processed/ZOOM0016.wav" => mod.read;
13 * 10 => mod.gain;
-0.21 => mod.rate;

class synt0 extends SYNT{

//    inlet => SinOsc sin =>  outlet; 
//    s => sin;
//    .5 => sin.gain;
    
    8 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    Step det_amount[synt_nb];
    SinOsc s[synt_nb];
    Gain final => outlet; .3 => final.gain;

    inlet => detune[i] => s[i] => final; mod => detune[i]; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final; mod => detune[i]; det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final; mod => detune[i]; det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   

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


STBPF bpf;
bpf.connect(last $ ST , 100 /* freq */  , 1.0 /* Q */  );       bpf $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 6. /* static gain */  );       stgain $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 



while(1) {
       mod.samples() => mod.pos;
       33 * data.tick => now;
}
 

