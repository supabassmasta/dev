public class STRINGBASS extends SYNT{

		8 => int synt_nb; 0 => int i;
		Gain detune[synt_nb];
		SinOsc s[synt_nb];
		Gain final=> ABSaturator sat  => outlet;
	.5=> sat.drive;
0 => sat.dcOffset;
	
		.5 => final.gain;

		.0075 => float det;
//		.0020 => float det;

		inlet => detune[i] => s[i] => final;    1. - 2*det -0.00011 => detune[i].gain;    .41 => s[i].gain; i++;  
		inlet => detune[i] => s[i] => final;    1. - 1*det +0.000  => detune[i].gain;    .6 => s[i].gain; i++;  
		inlet => detune[i] => s[i] => final;    1. + 1*det +0.00013 => detune[i].gain;    .61 => s[i].gain; i++;  
		inlet => detune[i] => s[i] => final;    1. + 2*det +0.00016 => detune[i].gain;    .39 => s[i].gain; i++;  

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

