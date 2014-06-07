class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.2=> s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; //8 => f0.max; 1=> f0.sync;
"0_3_3_ _4_4" =>     f0.seq;     
f0.reg(synt0 s0);
f0.adsr.set(100::ms, 0::ms, 1., 200::ms);
f0.post() => GVerb gverb0  => dac;
//f0.post()    => dac;GVerb gverb0;

30 => gverb0.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
1::second => gverb0.revtime;   // revtime: (dur), default 5::second
0.1 => gverb0.dry;             // dry (float) [0.0 - 1.0], default 0.6                
0.5 => gverb0.early;           // early (float) [0.0 - 1.0], default 0.4
0.3 => gverb0.tail;            // tail (float) [0.0 - 1.0], default 0.5              
//0.8 => gverb0.damping;         // damping: (float), [0.0 - 1.0], default 0.8
//0.5 => gverb0.inputbandwidth;  // inputbandwidth: (float) [0.0 - 1.0], default 0.5
//15. => gverb0.spread;          // spread: (float), default 15.0

while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; :w

