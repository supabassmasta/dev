class synt0 extends SYNT{

		inlet => Gain in => SqrOsc s => LPF lpf =>  outlet;		
				.2 => s.gain;
				.25 => in.gain;

				fun void f1 (){ 
					while(1) {
						//	<<<"POT",LPD8.pot[0][0]>>>; 
						Std.mtof(LPD8.pot[0][0]) => lpf.freq;
						LPD8.pot[0][1] * 12. / 127. => lpf.Q;
						LPD8.pot[0][2] / 127. => s.width;	
						10::ms => now;
					}
 
			 } 
			 spork ~ f1 ();
			  

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 


lpk25 l;
POLY synta; 
l.reg(synta);
synta.reg(synt0 s0);  synta.a[0].set(3::ms, 30::ms, .7, 100::ms);
synta.reg(synt0 s1);  synta.a[1].set(3::ms, 30::ms, .7, 100::ms);
synta.reg(synt0 s2);  synta.a[2].set(3::ms, 30::ms, .7, 100::ms);
synta.reg(synt0 s3);  synta.a[3].set(3::ms, 30::ms, .7, 100::ms); 

STECHO ech;
ech.connect(synta $ ST , 3 * data.tick / 4, .7); 

STREV1 rev;
rev.connect(synta $ ST, .4 /* mix */); 

while(1) {
	     100::ms => now;
}
 

