public class CHILL extends SYNT{

		inlet => SqrOsc s => BPF lpf => /* BPF bpf2 =>*/  outlet;		
		.1 => s.width;
				.1=> s.gain;
		4 => lpf.gain;
//		4 => bpf2.gain;
		Step step => ADSR ad => blackhole;
		4 => lpf.Q;
//		4 => bpf2.Q;
		2000 => lpf.freq;
		1 => step.next;
		ad.set(50::ms, 50::ms, .1, 20::ms);

		fun void f1 (){ 
				while(1) {
//						ad.last() *1500 +300 + (Math.sin (.9 * pi * (now / 1::second) )  ) * 300 + (Math.sin (.2 * pi * (now / 1::second) ) + 1 ) * 800  => lpf.freq;
						ad.last() *2500 +300 + LPD8.k(2,2) * 40 +  (Math.sin (.9 * pi * (now / 1::second) )  ) * 15 * LPD8.k(2,3)  + (Math.sin (.2 * pi * (now / 1::second) ) + 1 ) * 20 * LPD8.k(2,4) => lpf.freq ;//  => bpf2.freq;
//						(ad.last()/3 + .1 )	 => s.width;
								LPD8.k(2,1) / 127.	 => s.width;
//								lpd8_master.pot[0][1] * 20.	 => lpf.freq;
//								LPD8.k(2,8) * 20.	 => lpf.freq;
//								<<<s.width(), lpd8_master.pot[0][0]>>>; 
					     1::ms => now;
				}
				 
	 } 
	 spork ~ f1 ();
	  
						fun void on()  { }	fun void off() { }	
						
		fun void new_note(int idx)  {	ad.keyOn();	}
}
/*

FREQ_STR f0; //8 => f0.max; 1=> f0.sync;
"*4 <7 0525 2645 2435 4361 2958 6709 3749 3749 " =>     f0.seq;     
//"*4 0123 " =>     f0.seq;     
f0.reg(synt0 s0);
f0.adsr.set(10::ms, 5::ms, .8, 20::ms);
//f0.post() => Gain fb => GVerb gverb0  => dac;
//f0.post()    => dac;GVerb gverb0;
f0.post()    => global_mixer.line4;GVerb gverb0;

//fb => Delay d => fb;
//data.tick => d.max => d.delay;
//.6 => d.gain;

3 => gverb0.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
1::second => gverb0.revtime;   // revtime: (dur), default 5::second
0.8 => gverb0.dry;             // dry (float) [0.0 - 1.0], default 0.6                
0.5 => gverb0.early;           // early (float) [0.0 - 1.0], default 0.4
0.3 => gverb0.tail;            // tail (float) [0.0 - 1.0], default 0.5              
//0.8 => gverb0.damping;         // damping: (float), [0.0 - 1.0], default 0.8
//0.5 => gverb0.inputbandwidth;  // inputbandwidth: (float) [0.0 - 1.0], default 0.5
//15. => gverb0.spread;          // spread: (float), default 15.0

while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; :w
*/
