class synt0 extends SYNT{

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


lpk25 l;
POLY synta; 
l.reg(synta);
synta.reg(synt0 s0);  synta.a[0].set(1000::ms, 300::ms, .7, 1000::ms);
synta.reg(synt0 s1);  synta.a[1].set(1000::ms, 300::ms, .7, 1000::ms);
synta.reg(synt0 s2);  synta.a[2].set(1000::ms, 300::ms, .7, 1000::ms);
synta.reg(synt0 s3);  synta.a[3].set(1000::ms, 300::ms, .7, 1000::ms); 
synta.reg(synt0 s4);  synta.a[4].set(1000::ms, 300::ms, .7, 1000::ms); 
synta.reg(synt0 s5);  synta.a[5].set(1000::ms, 300::ms, .7, 1000::ms); 
synta.reg(synt0 s6);  synta.a[6].set(1000::ms, 300::ms, .7, 1000::ms); 

STREV1 rev;
rev.connect(synta $ ST, .6 /* mix */); 

while(1) {
	     100::ms => now;
}
 

