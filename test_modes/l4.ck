class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SqrOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; .3 => s[i].width; i++;  
inlet => detune[i] => s[i] => final;    1.001 => detune[i].gain;    .6 => s[i].gain; .23 => s[i].width; i++;  


						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; //8 => f0.max; 1=> f0.sync;
"<c 0000 00__ 4465 34__ " =>     f0.seq;     
f0.adsr.set(300::ms, 40::ms, .8, 500::ms);
f0.reg(synt0 s0);
//f0.post()  => dac;

while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
