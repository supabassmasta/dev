class synt0 extends SYNT{

		inlet => Gain in => SinOsc s => LPF filter => Gain out => outlet;		
		in => TriOsc s2 =>  out;		
				1.3 => s.gain;
				.25 => s2.gain;
				.84 => s2.width;
		Noise n => LPF nf => in;

		2000 => nf.freq;
		3. => n.gain;		


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



						fun void on()  { padsr.keyOn();}	fun void off() {padsr.keyOff(); }	fun void new_note(int idx)  {		}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c *4 111_ 111_ 1_1_ 1___ 
			 __1_ 3_3_ 3_3_ 3_55 	
			 111_ 111_ 1_1_ 1___ 
			 __1_ 0_B_ B_B_ B_00 	
			 
			 
			 " => t.seq;
//			 ____ ____ ____ ____ 	
.4 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

while(1) {
	     100::ms => now;
}
 
