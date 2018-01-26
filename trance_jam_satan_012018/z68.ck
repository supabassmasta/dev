class synt0 extends SYNT{
	    inlet => Gain in;
			Gain out =>  outlet;   

			0 => int i;
			Gain opin[8];
			Gain opout[8];
			PowerADSR adsrop[8];
			SinOsc osc[8];

			// build and config operators
			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			1. => opin[i].gain;
			adsrop[i].set(1::ms, 2*data.tick, .5 , 200::ms);
			adsrop[i].setCurves(1.0, .8, .5);
			1 => adsrop[i].gain;
			i++;

			//---------------------
			opin[i] => TriOsc tri=> adsrop[i] => opout[i];
			.6 => tri.width;
			1./2. + 0.0 => opin[i].gain;
			adsrop[i].set(4 * data.tick , 4*data.tick, .00001 , 200::ms);
			adsrop[i].setCurves(2.0, .7, .5);
			100 * 3 => adsrop[i].gain;
			i++;

		SinOsc trimod => blackhole;
		.5 => trimod.freq;
		fun void f1 (){ 
						while(1) {
						  (trimod.last() + 1)	/2 => tri.width;	
							1./2. +	trimod.last()/10. => opin[i].gain;

						  10::ms => now;
						}
						 

			 } 
			 spork ~ f1 ();
			  

			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			1. => opin[i].gain;
			adsrop[i].set(1::ms, 2*data.tick, .5 , 200::ms);
			adsrop[i].setCurves(1.0, .8, .5);
			.7 => adsrop[i].gain;
			i++;

			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			1./2. +0.000 => opin[i].gain;
			adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
			adsrop[i].setCurves(2.0, 2.0, .5);
			30 => adsrop[i].gain;
			i++;

			// connect operators
			// main osc
			in => opin[0]; opout[0]=> out; 

			// modulators
			in => opin[1];
			opout[1] => opin[0];

			in => opin[2]; opout[2]=> out; 
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
":2 {c 

1111 ____
3333 ____
55!11 ____
0000 ____

1111 ____
3333 ____
44!11 ____
0000 !55__
" => t.seq;
1.5 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, 1, 4*data.tick);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();


while(1) {
	     100::ms => now;
}
 
