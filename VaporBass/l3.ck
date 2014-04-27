class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
TriOsc s[synt_nb];
Gain final => outlet; .2 => final.gain;

inlet => detune[i] => s[i] => final;    1.00 => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.02 => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.03 => detune[i].gain;    .6 => s[i].gain; i++;  

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; 4 => f0.max; 1=> f0.sync;

"*8<a 0_0_0_0_0___4__2__4////0_-6*2a____a_a________________________________________________" =>     f0.seq;     
f0.reg(synt0 s0);
//f0.post()  => dac;

while(1) {  100::ms => now; }
				 
