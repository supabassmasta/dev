class GRAIN extends SYNT{

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


