
class synt0 extends SYNT{

   inlet => SinOsc s =>  outlet;   
   .1 => s.gain;

   TriOsc mod => ADSR a => s; 
   20 => mod.freq; 
   69 => mod.gain;
   a.set (4000::ms, 0::ms, 1., 10::ms);
   fun void on()  { a.keyOn(); }  fun void off() {a.keyOff(); }  fun void new_note(int idx)  {   }
 }


FREQ_STR f0; 64 => f0.max; 2=> f0.sync;
"ALL" => f0.scale;
">c :8 0_7_5_*8*8 73539_" =>     f0.seq;     
f0.reg(synt0 s0);
f0.post()  => Gain fb => dac;
fb => Delay d => fb;
.8 => d.gain;
2000::ms => d.delay => d.max;

while(1) {  100::ms => now; }
            //data.meas_size * data.tick => now; 
