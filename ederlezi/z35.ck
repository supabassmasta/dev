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
		adsrop[i].set(8::ms, 51::ms, .7 , 1200::ms);
		adsrop[i].setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
		1 => adsrop[i].gain;
		i++;

		//---------------------
		opin[i] => osc[i] => adsrop[i] => opout[i];
		1./2. + 0.9 => opin[i].gain;
		adsrop[i].set(.5*data.tick, .5*data.tick, .4 , 200::ms);
		adsrop[i].setCurves(.2, .2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
		15*10  => adsrop[i].gain;
		i++;

		//---------------------
		opin[i] => osc[i] => adsrop[i] => opout[i];
		1./24. +0.1 => opin[i].gain;
		adsrop[i].set(10::ms, 186::ms, .5 , 1800::ms);
		adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
		12 * 10 => adsrop[i].gain;
		i++;

		//---------------------
		opin[i] => osc[i] => adsrop[i] => opout[i];
		1./6. +0.000 => opin[i].gain;
		adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
		adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
		53 => adsrop[i].gain;
		i++;

		// connect operators
		// main osc
		in => opin[0]; opout[0]=> out; 

		// modulators
		in => opin[1];
		opout[1] => opin[0];

		in => opin[2];
		 opout[2] => opin[1];

		in => opin[3];
//		 opout[3] => opin[1];


		.5 => out.gain;

		fun void on()  
		{
			for (0 => int i; i < 8      ; i++)
			{
				    adsrop[i].keyOn();
//						     0=> osc[i].phase;
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
						 1 => own_adsr;
}  


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 
____  ____  
____  8////C  
____  ____  
____  ____  
____  ____  
____  c////1  
____  ____  
____  ____  

" => t.seq;
.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 , .6);  ech $ ST @=>  last; 

STECHO ech2;
ech2.connect(last $ ST , data.tick * 3 / 4 , .7);  ech2 $ ST @=>  last; 


//STBPF bpf;
//bpf.connect(last $ ST , 7 * 100 /* freq */  , 4.0 /* Q */  );       bpf $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 5*100 /* freq */  , 2.0 /* Q */  );       hpf $ ST @=>  last; 

while(1) {
	     100::ms => now;
}
 
