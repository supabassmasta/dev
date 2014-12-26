


class synt0 extends SYNT{

				
		inlet => Gain in =>  TriOsc s => Gain out => outlet;

		in => Gain modg => SawOsc mod => s;

		.207 => modg.gain;
		292. => mod.gain;
		
		SawOsc mod2 => s;
		334 => mod.freq;
		1800 =>  mod2.gain;

		.4 => s.gain;


						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; //8 => f0.max;
2=> f0.sync;
">c >c  *8 0___ __3_ 4___  0_0_      4_0_ 6___ 0___ __3_ 4___ 5_5_ 5_5_    4_4_ 4_4_ " =>     f0.seq;     
f0.adsr.set(1::ms, 4::ms, .2, 10::ms);
f0.reg(synt0 s1);
f0.post()  => Gain tamp => dac;
tamp => Delay d => tamp;
 .8 => d.gain;
72::ms => d.max;
10::ms => d.delay;

fun void f1 (){ 
		while(1) {

			LPD8.k(2,1) * 12::samp => d.delay;
			     10::ms => now;
		}
		 

		
	 } 
	 spork ~ f1 ();
	  


/*fun void f1 (){ 
		while(1) {
 Math.random2f(0.01, 10.) * 1::ms => d.delay;
			     542::ms => now;
		}
		 

	 } 
	 spork ~ f1 ();
	*/  


while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
