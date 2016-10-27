class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet;   
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 


POLY synta; 
synta.reg(synt0 s0);  synta.a[0].set(3::ms, 30::ms, .7, 100::ms);
synta.reg(synt0 s1);  synta.a[1].set(3::ms, 30::ms, .7, 100::ms);
synta.reg(synt0 s2);  synta.a[2].set(3::ms, 30::ms, .7, 100::ms);
synta.reg(synt0 s3);  synta.a[3].set(3::ms, 30::ms, .7, 100::ms); 


while(1) {
    MidiMsg msg;

    144 => msg.data1;
    77 => msg.data2;
    127 => msg.data3;
    synta.in(msg);
    100::ms => now;

    128 => msg.data1;
    77 => msg.data2;
    0 => msg.data3;
    synta.in(msg);
    300::ms => now;
}
 
