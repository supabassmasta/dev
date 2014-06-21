SEQ_STR s0; // 4 => s0.max; 0 => s0.sync;

s0.reg(0, "../_SAMPLES/amen_kick.wav");
s0.reg(1, "../_SAMPLES/amen_snare.wav");
s0.reg(2, "../_SAMPLES/amen_snare2.wav");
s0.reg(3, "../_SAMPLES/amen_hit.wav");
//s0.reg("A", "../_SAMPLES/REGGAE_SET_1/Timbales1_Reaggae1.wav");

"*4 5_5_e_5_" => s0.seq; 
"*4 __55e5__" => s0.seq; 
"*4 __5_e__5" => s0.seq; 
"*4 5___e___" => s0.seq; 
s0.post() => Gain mult => LPF lpf1 => GVerb gverb0  => dac;

3974 => lpf1.freq;
.7 => lpf1.gain;
3 => mult.op;

ibniz ib => LPF lpf => mult;

fun void f1 (){ 
		while(1) {
		ib.reset();
		<<<"RESET IB">>>; 
			     data.tick * 8 => now;
		}
		 

	 } 
	 spork ~ f1 ();
	  

1000 => lpf.freq;


"2/drst" => ib.code;


93 => gverb0.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
3::second => gverb0.revtime;   // revtime: (dur), default 5::second
0.92 => gverb0.dry;             // dry (float) [0.0 - 1.0], default 0.6                
0.9 => gverb0.early;           // early (float) [0.0 - 1.0], default 0.4
0.3 => gverb0.tail;            // tail (float) [0.0 - 1.0], default 0.5       

s0.go();
while(1) { 100::ms => now; }
//data.meas_size * data.tick => now; 
