class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .3 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

lpk25 l;
POLY synta; 
l.reg(synta);
synta.reg(synt0 s0);  synta.a[0].set(3::ms, 30::ms, .7, 5 *100::ms);
synta.reg(synt0 s1);  synta.a[1].set(3::ms, 30::ms, .7, 5 *100::ms);
synta.reg(synt0 s2);  synta.a[2].set(3::ms, 30::ms, .7, 5 *100::ms);
synta.reg(synt0 s3);  synta.a[3].set(3::ms, 30::ms, .7, 5 *100::ms); 

// Note info duration
10 * 100::ms => synta.ni.d;

synta $ ST @=> ST @ last;

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 4 * 100 /* Variable */, 8. /* Q */);
stsynclpf.adsr_set(.1 /* Relative Attack */, .4/* Relative Decay */, .6 /* Sustain */, .2 /* Relative Sustain dur */, 2. /* Relative release */);
stsynclpf.connect(last $ ST, synta.note_info_tx_o); stsynclpf $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
