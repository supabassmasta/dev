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
			100 * 5 => adsrop[i].gain;
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
			Noise n => opin[0];	
			10 * 2 => n.gain;	

			in => opin[2];
			// opout[2] => opin[0];

			in => opin[3];
			// opout[3] => opin[0];


			.05 => out.gain;

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
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s3);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s4);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s5);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s6);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion();  
t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c  *4  1_1_ 2_74 _5!5!5 1!1__" => t.seq;
// t.element_sync();//  t.no_sync();//  t.full_sync();     
t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(200::ms, 10::ms, 1., 800::ms);
t.adsr[1].set(200::ms, 10::ms, 1., 800::ms);
t.adsr[2].set(200::ms, 10::ms, 1., 800::ms);
t.adsr[3].set(200::ms, 10::ms, 1., 800::ms);
t.adsr[4].set(200::ms, 10::ms, 1., 800::ms);
t.adsr[5].set(200::ms, 10::ms, 1., 800::ms);
t.go(); 


STREV1 rev;
rev.connect(t $ ST, .1 /* mix */); 

STDUCK duck;
duck.connect(rev $ ST); 




while(1) {
	     100::ms => now;
}
 
