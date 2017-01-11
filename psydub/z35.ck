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
			100 * 4 => adsrop[i].gain;
			i++;

			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			1./4. +0.0 => opin[i].gain;
			adsrop[i].set(10::ms, 100::ms, .1 , 200::ms);
			43 => adsrop[i].gain;
			i++;

			//---------------------
			opin[i] => osc[i] => adsrop[i] => opout[i];
			1. => opin[i].gain;
			adsrop[i].set(10::ms, 100::ms, .9 , 200::ms);
			.6 => adsrop[i].gain;
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
		//	 opout[3] => out; 


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




			fun void f1 (){ 
					while(1) {
						//	<<<"POT",LPD8.pot[0][0]>>>; 
						 LPD8.pot[1][0]  * 8 + LPD8.pot[1][1] / ( 1 * 127.) => adsrop[1].gain;
						1./2. + LPD8.pot[1][1] / ( 1 * 127.) => opin[1].gain;
						// LPD8.pot[1][0]  * 8  => adsrop[1].gain;
						//LPD8.pot[1][1]  * 8  => adsrop[2].gain;
						LPD8.pot[1][2]  * 8  => adsrop[3].gain;
						10::ms => now;
					}
 
			 } 
			 spork ~ f1 ();


}  


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s3);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4" => t.seq;  
"_1!1!1" => t.seq;
"_1!1!1" => t.seq;
"_1!1!1" => t.seq;
"_1!5!4" => t.seq;
.7 => t.gain;
 t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

STDUCK duck;
duck.connect(t $ ST); 

while(1) {
	     100::ms => now;
}
 
