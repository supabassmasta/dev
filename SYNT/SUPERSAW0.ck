public class SUPERSAW0 extends SYNT{

	8 => int synt_nb; 0 => int i;
	Gain detune[synt_nb];
	TriOsc s[synt_nb];
	Gain final => outlet; .15 => final.gain;

	.007 => float offset;
	fun float comp_detune(int i) {
		return i * offset - 0.1 + Math.random2f(-0.001, 0.001);

	}
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  

	fun void f1 (){ 

		while(1) {
			if (LPD8.k(2,1)< 130) {
				for (0 =>  i; i < detune.size()     ; i++) {
					LPD8.k(2,1) / (128. * 9.) => s[i].width;
				}
			}

			if (LPD8.k(2,2)< 130) {
				LPD8.k(2,2) / 10000. => offset;
				for (0 =>  i; i < detune.size()     ; i++) {
					1. + comp_detune(i) => detune[i].gain;
				}
			}


			100::ms => now;
		}
	} 
	spork ~ f1 ();


	// init width
	for (0 =>  i; i < detune.size()     ; i++) {
		0. => s[i].width;
	}

	fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 


// TEST
/*
FREQ_STR f0; 8 => f0.max; 0=> f0.sync;
"<c 0234 *26//0 _2_2_2 ___________" =>     f0.seq;     
f0.reg(synt0 s0);
//f0.post()  => dac;

while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
*/

