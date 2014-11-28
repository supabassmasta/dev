class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.2 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; //8 => f0.max; 
1=> f0.sync;

"DOR" => f0.set_scale;
"*2 04050406" =>     f0.seq;     
"<5 *2 04050406" =>     f0.seq;     
"*2 04050406" =>     f0.seq;     
"<7 *2 04050406" =>     f0.seq;     
f0.reg(synt0 s0);

class synt1 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SinOsc s[synt_nb];
Gain final => outlet; .1 => final.gain;

inlet => detune[i] => s[i] => final;    1.  => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.2 => detune[i].gain;    .5 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.5 => detune[i].gain;    .5 => s[i].gain; i++;  

				fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {	}
}


FREQ_STR f1; //8 => f1.max;

1=> f1.sync;
"*4 >c     __4_0_4_ __4_0_4_  " =>     f1.seq;     
"*4 >c <5  __4_0_4_ __4_0_4_  " =>     f1.seq;     
"*4 >c     __4_0_4_ __4_0_4_  " =>     f1.seq;     
"*4 >c <7  __4_0_4_ __4_0_4_  " =>     f1.seq;     
f1.reg(synt1 s1);
//f1.post()  => dac;



while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
