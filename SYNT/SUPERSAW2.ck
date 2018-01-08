public class SUPERSAW2 extends SYNT{

	8 => int synt_nb; 0 => int i;
	Gain detune[synt_nb];
	TriOsc s[synt_nb];
	Gain final => outlet; .15 => final.gain;

	.001 * 4 => float offset;
	fun float comp_detune(int i) {
		return i * offset- 0.1 + Math.random2f(-0.001, 0.001) ;

	}
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  


	// init width
	for (0 =>  i; i < detune.size()     ; i++) {
		0. => s[i].width;
	}

	fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

