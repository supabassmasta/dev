class synt0 extends SYNT{

		inlet => SqrOsc s => Gain out; 
	 out => 	BRF fi => LPF lpf =>	GVerb gverb0  =>	outlet;		

30 => gverb0.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
2::second => gverb0.revtime;   // revtime: (dur), default 5::second
0.8 => gverb0.dry;             // dry (float) [0.0 - 1.0], default 0.6                
0.5 => gverb0.early;           // early (float) [0.0 - 1.0], default 0.4
0.3 => gverb0.tail;            // tail (float) [0.0 - 1.0], default 0.5       
		6000 => lpf.freq;
		3 => lpf.Q;

1000 => fi.freq;
		1 => fi.Q;

				.1 => s.gain;
				.4 => s.width;
		inlet => SinOsc s2 =>  out;		
				.4 => s2.gain;
//				.9 => s.width;
inlet => Gain sub => SinOsc s3 => out;
.5 => sub.gain;
.3 => s3.gain;

		TriOsc m => s;
		2::second/data.tick => m.freq;
		5.6 => m.gain;

				
						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; //8 => f0.max;
2=> f0.sync;
"*4 <e  000000_0  __0_0_0_  0_0_00__  __00____         00000__0  __0_0_0_  00__00__  0_00__00 " =>     f0.seq;     
"*4 <c  000000_0  __0_0_0_  0_0_00__  __00____         00000__0  __0_0_0_  00__00__  0_00_00// " =>     f0.seq;     
//"*8 <e  00000000  00000_00  0_0_00__  __0000__         0000__00  __0_0_0_  00__00__  0000__00 " =>     f0.seq;     
//"*8 <e  00000000  00_000//  9999//00  __0_00__         00__00__  0_0///77  7777//00  0000__00 " =>     f0.seq;     
f0.reg(synt0 s0);



f0.post() => DUCK duck => Gain out  => dac;
.9 => out.gain;
duck.set(2::ms, 40::ms, .4, 8::ms);
DUCK_MASTER.auto();
while(1) {  100::ms => now; }
//data.meas_size * data.tick => now;		
