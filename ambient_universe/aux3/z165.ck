class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
    .1 => s.width;
      .5 => s.gain;

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


STEQ steq;
steq.connect(last $ ST, HW.lpd8.potar[1][1] /* HPF freq */, HW.lpd8.potar[1][2] /* HPF Q */, HW.lpd8.potar[1][3] /* LPF freq */, HW.lpd8.potar[1][4] /* LPF Q */
 , HW.lpd8.potar[1][5] /* BRF1 freq */, HW.lpd8.potar[1][6] /* BRF1 Q */, HW.lpd8.potar[1][7] /* BRF2 freq */, HW.lpd8.potar[1][8] /* BRF2 Q */
  , HW.lpd8.potar[2][1] /* BPF1 freq */, HW.lpd8.potar[2][2] /* BPF1 Q */, HW.lpd8.potar[2][3] /* BPF1 Gain */
   , HW.lpd8.potar[2][5] /* BPF2 freq */, HW.lpd8.potar[2][6] /* BPF2 Q */, HW.lpd8.potar[2][7] /* BPF2 Gain */
    , HW.lpd8.potar[2][8] /* Output Gain */  ); steq $ ST @=>  last; 

    while(1) {
           100::ms => now;
    }
     

