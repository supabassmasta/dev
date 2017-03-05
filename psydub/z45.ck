class synt0 extends SYNT{
	    inlet => Gain in;
			Gain out => LPF filter => outlet;   

			// Filter to add in graph
			// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
			Step base => Gain filter_freq => blackhole;
			Step variable => PowerADSR padsr => filter_freq;

			// Params
			padsr.set(data.tick / 6 , data.tick / 8 , .0000001, data.tick / 4);
			padsr.setCurves(1.0, 2.0, .5);
			3 => filter.Q;
			48 => base.next;
			5300 => variable.next;

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


			0 => int i;
			Gain opin[8];
			Gain opout[8];
			ADSR adsrop[8];
			SinOsc osc[8];

			// build and config operators
			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			1. => opin[i].gain;
			adsrop[i].set(1::ms, 20::ms, .7 , 200::ms);
			1 => adsrop[i].gain;
			i++;

			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			1./2. + 0.00 => opin[i].gain;
			adsrop[i].set(150::ms, 307::ms, .1 , 200::ms);
			100 * 48 => adsrop[i].gain;
			i++;

			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			1./4. +0.0 => opin[i].gain;
			adsrop[i].set(100::ms, 186::ms, .5 , 1800::ms);
			14 * 10 => adsrop[i].gain;
			i++;

			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			1./2. +0.000 => opin[i].gain;
			adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
			30 => adsrop[i].gain;
			i++;

			// connect operators
			// main osc
			in => opin[0]; opout[0]=> out; 

			// modulators
			in => opin[1];
			opout[1] => opin[0];

			in => opin[2];
			 opout[2] => opin[0];

			in => opin[3];
			// opout[3] => opin[0];


			.3 => out.gain;

		SinOsc modmod => blackhole;
		1::second / (data.tick * 9) => modmod.freq;
		fun void f1 (){ 
				while(1) {
						(modmod.last() + 1) * 169  + 30 => adsrop[2].gain;
					     1::ms => now;
				}
			 } 
			 spork ~ f1 ();
			  

			fun void on()  
			{
				  for (0 => int i; i < 8      ; i++)
					{
						  adsrop[i].keyOn();
							// 0=> osc[i].phase;
					}
					      
			} 
			    
					fun void off() 
					{
						  for (0 => int i; i < 8      ; i++) 
							{
								  adsrop[i].keyOff();
							}
							            
													      
					} 
					    
							fun void new_note(int idx)  
							{ 
								 padsr.keyOn();        
							}
}  


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*3 }c !1!1!1 ___ ___ ___" => t.seq;
.2 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

while(1) {
	     100::ms => now;
}
 

