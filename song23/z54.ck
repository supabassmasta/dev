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
			adsrop[i].set(1::ms,.5*data.tick, .5 , 4* data.tick);
			adsrop[i].setCurves(1.0, .8, .5);
			1 => adsrop[i].gain;
			i++;

			//---------------------
			opin[i] => TriOsc tri=> adsrop[i] => opout[i];
			.6 => tri.width;
			1./2. + 0.0 => opin[i].gain;
			adsrop[i].set(1 * data.tick , 1*data.tick, .00001 , 200::ms);
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
//			 spork ~ f1 ();
			  

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
" {c 
!111_ ____
111_ ___8
!111_ ____
111_ __8!5
" => t.seq;
0.4 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, 1, 4*data.tick);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();t $ ST @=> ST @  last;

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(0 /* 0 : left, 1: right 2: both */, .3 /* delay line gain */,  5::ms /* dur base */, 3::ms /* dur range */, 5 /* freq */); 
//flang.add_line(1 /* 0 : left, 1: right 2: both */, .3 /* delay line gain */,  5::ms /* dur base */, 3::ms /* dur range */, 5.1 /* freq */); 

STHPF hpf;
hpf.connect(last $ ST , 50 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STLPF lpf;
lpf.connect(last $ ST , 6 * 100 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .1 /* mix */);     rev  $ ST @=>  last; 

while(1) {
	     100::ms => now;
}
 
