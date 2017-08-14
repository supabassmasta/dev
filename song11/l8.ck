class synt0 extends SYNT{
	    inlet => Gain in;
			Gain out =>  outlet;   

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
			adsrop[i].set(10::ms, 100::ms, .1 , 200::ms);
			100 * 1 => adsrop[i].gain;
			i++;

			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			2 +0.0 => opin[i].gain;
			adsrop[i].set(100::ms, 186::ms, .5 , 1800::ms);
			.5 => adsrop[i].gain;
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
			in => opin[1] => opin[2];
			opout[1] => opin[0];

			in => opin[2];
			 opout[2] => out;

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
"*2 {c 11__ 55_5 __5_ 111_ 11__ 5___ _8//1_ 1_1_" => t.seq;
.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 60::ms, .9, 400::ms);
t.adsr[0].setCurves(.4, 3.0, 3.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();

STREV1 rev;
rev.connect(t $ ST, .03 /* mix */); 

while(1) {
	     100::ms => now;
}
 


