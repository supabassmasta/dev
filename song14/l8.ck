class synt0 extends SYNT{
	  inlet => Gain in;
		Gain out => LPF filter =>  outlet;   

// Filter to add in graph
// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
Step base => Gain filter_freq => blackhole;
Step variable => PowerADSR padsr => filter_freq;

// Params
padsr.set(data.tick * 2 , data.tick * 4 , .0000001, data.tick / 4);
padsr.setCurves(2.0, 2.0, .5);
4 => filter.Q;
48 => base.next;
17 * 100 => variable.next;

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
		PowerADSR adsrop[8];
		TriOsc osc[8];

		// build and config operators
		//---------------------
		opin[i] => osc[i] => adsrop[i] => opout[i];
		1. => opin[i].gain;
		adsrop[i].set(1::ms, 20::ms, .7 , 200::ms);
		adsrop[i].setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
		1 => adsrop[i].gain;
		.9 => osc[i].width;
		i++;

		//---------------------
		opin[i] => osc[i] => adsrop[i] => opout[i];
		1./2. + 0.03 => opin[i].gain;
		adsrop[i].set(1.5*data.tick, 1.5*data.tick, .00001 , 200::ms);
		adsrop[i].setCurves(.2, .2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
		100 * 2 => adsrop[i].gain;
		.6 => osc[i].width;
		i++;

		//---------------------
		opin[i] => osc[i] => adsrop[i] => opout[i];
		1./8. +0.0 => opin[i].gain;
		adsrop[i].set(5*data.tick, 1*data.tick, .1 , 1800::ms);
		adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
		11 *10 => adsrop[i].gain;
		.6 => osc[i].width;
		i++;

		//---------------------
		opin[i] => osc[i] => adsrop[i] => opout[i];
		1./2. +0.000 => opin[i].gain;
		adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
		adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
		30 => adsrop[i].gain;
		.9 => osc[i].width;
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


		.5 => out.gain;

		fun void on()  
		{
			for (0 => int i; i < 8      ; i++)
			{
				    adsrop[i].keyOn();
						    // 0=> osc[i].phase;
			}
			padsr.keyOn();      
		} 
		    
				fun void off() 
				{
					for (0 => int i; i < 8      ; i++) 
					{
						    adsrop[i].keyOff();
					}
					  padsr.keyOff();          
											                  
				} 
				    
						fun void new_note(int idx)  
						{ 
							           
						}
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  

"{c *2
____ ____ 
____ ____ 
____ 

!1111 11__
____   
" => t.seq;

.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

STECHO ech;
ech.connect(t $ ST , data.tick * 1 / 1 , .5); 

STFILTERMOD fmod;
fmod.connect( ech , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 400  /* f_var */, 4::second / (3 * data.tick) /* f_mod */); 

while(1) {
	     100::ms => now;
}
 
