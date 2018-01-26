class synt0 extends SYNT{

		inlet => SinOsc s => LPF filter => Gain out => outlet;		
		inlet => TriOsc s2 =>  out;		
				1.3 => s.gain;
				.33 => s2.gain;
				.84 => s2.width;

// Filter to add in graph
// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
Step base => Gain filter_freq => blackhole;
Step variable => PowerADSR padsr => filter_freq;

// Params
padsr.set(data.tick / 4 , data.tick / 8 , .8, data.tick / 4);
padsr.setCurves(2., 2.0, .5);
1 => filter.Q;
48 => base.next;
800 => variable.next;

// ADSR Trigger
//padsr.keyOn(); padsr.keyOff();

// fun void auto_off(){
	//     data.tick / 4 => now;
	//     padsr.keyOff();
	// }
	// spork ~ auto_off();

	fun void filter_freq_control (){ 
		    while(1) {
					      filter_freq.last() => filter.freq;
								      1::ms => now;
											    }
	} 
	spork ~ filter_freq_control (); 



						fun void on()  { }	fun void off() {padsr.keyOff(); }	fun void new_note(int idx)  {	padsr.keyOn();	}
} 

lpk25 l;
POLY synta; 
l.reg(synta);
synta.reg(synt0 s0);  synta.a[0].set(3::ms, 30::ms, .7, 100::ms);
synta.reg(synt0 s1);  synta.a[1].set(3::ms, 30::ms, .7, 100::ms);
synta.reg(synt0 s2);  synta.a[2].set(3::ms, 30::ms, .7, 100::ms);
synta.reg(synt0 s3);  synta.a[3].set(3::ms, 30::ms, .7, 100::ms); 

while(1) {
	     100::ms => now;
}
 
