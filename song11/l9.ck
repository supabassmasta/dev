class synt0 extends SYNT{
	    inlet => Gain in;
			Gain out =>  outlet;   

			0 => int i;
			Gain opin[8];
			Gain opout[8];
			ADSR adsrop[8];
			SqrOsc osc[8];

			// build and config operators
			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			1. => opin[i].gain;
			adsrop[i].set(1::ms, 20::ms, .7 , 200::ms);
			1 => adsrop[i].gain;
			i++;

			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			1./4. + 0.03 => opin[i].gain;
			adsrop[i].set(10::ms, 100::ms, .1 , 200::ms);
			100 * 1 => adsrop[i].gain;
			i++;

			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			1./8. +0.0 => opin[i].gain;
			adsrop[i].set(100::ms, 186::ms, .5 , 1800::ms);
			8 => adsrop[i].gain;
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
			// opout[2] => opin[0];

			in => opin[3];
			// opout[3] => opin[0];


			.5 => out.gain;

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
								         
							}
}  

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 !1!1!1!1!1!1!1!1 __!55 ____ __!5!8
		!1!1!1_ ____ !5_!7!8 _1_1 __8_
 !1!1!1!1!1!1!1!1! ____ !5!5!5!5  
		!1!1!1_ ____ !5_!4!8 _5_1 __4_
     " => t.seq;
.2 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 
ST st;

t.mono() =>  LPF filter =>  st.mono_in;
Step base => Gain filter_freq => blackhole;
Gain mod_out => Gain variable => filter_freq;
SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

// params
2 => filter.Q;
161 => base.next;
2051 => variable.gain;
1::second / (data.tick * 9 ) => mod.freq;
// If mod need to be synced
// 1 => int sync_mod;
// if (idx == 0) { if (sync_mod) { 0=> sync_mod; 0.0 => mod.phase; } }

fun void filter_freq_control (){ 
	    while(1) {
				      filter_freq.last() => filter.freq;
							      1::ms => now;
										    }
}
spork ~ filter_freq_control (); 


STAUTOPAN autopan;
autopan.connect(st $ ST, .9 /* span 0..1 */, 7*data.tick /* period */, 0.95 /* phase 0..1 */ );  


STDUCK duck;
duck.connect(autopan $ ST); 

while(1) {
	     100::ms => now;
}
 

