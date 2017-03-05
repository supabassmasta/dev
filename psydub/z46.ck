class synt0 extends SYNT{

		inlet => TriOsc s => LPF filter =>  BRF brf =>  outlet;		
				.9 => s.gain;
				.53 => s.width;

				226 => brf.freq;
				1=> brf.Q;

				// Filter to add in graph
				// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
				Step base => Gain filter_freq => blackhole;
				Step variable => PowerADSR padsr => filter_freq;

				// Params
				padsr.set(data.tick / 4 , data.tick / 4 , .7, data.tick );
				padsr.setCurves(0.2, 2.0, 2.);
				1.3 =>  filter.Q;
				38 => base.next;
				51 *10 => variable.next;

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
"*2 {c 3!1!1!1 !111_ _0!0!0 !00__ 
       3!1!1!1 _5!1_ _0!0!0 _78_ 
			 3!1!1!1 !111_ _0!0!0 !00__ 
       3!1!1!1 _0!0!0 _78_ 8!5//0_			 
			 " => t.seq;
.7 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(10::ms, data.tick / 2, .7, data.tick);
t.go(); 


//STBRFC brfc;
//brfc.connect(t $ ST , HW.lpd8.potar[1][7] /* freq */  , HW.lpd8.potar[1][8] /* Q */  );  

while(1) {
	     100::ms => now;
}
 
