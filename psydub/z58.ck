class synt0 extends SYNT{

		inlet => SqrOsc s => LPF filter =>  /* BRF brf => */  outlet;		
				.9 => s.gain;
				.5000 => s.width;

//				245 => brf.freq;
//				3=> brf.Q;

				// Filter to add in graph
				// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
				Step base => Gain filter_freq => blackhole;
				Step variable => PowerADSR padsr => filter_freq;

				// Params
				padsr.set(1::ms , data.tick / 6 , .4 , data.tick );
				padsr.setCurves(2, 0.68, 2.);
				3.5 =>  filter.Q;
				98 => base.next;
				22 *10 => variable.next;

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




						fun void on()  {padsr.keyOn(); }	fun void off() {padsr.keyOff(); }	fun void new_note(int idx)  {		}
}

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//"*2 {c 1111 _5!1_ 01_ !3!3!3_" => t.seq;
"*4 {c __!1_
			 " => t.seq;
.5 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, data.tick / 5, .3, data.tick);
t.go(); 

STDUCK duck;
duck.connect(t $ ST); 

//STBRFC brfc;
//brfc.connect(t $ ST , HW.lpd8.potar[1][7] /* freq */  , HW.lpd8.potar[1][8] /* Q */  );  

while(1) {
	     100::ms => now;
}
 
