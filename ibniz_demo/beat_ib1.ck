
SEQ_STR s0;  8 => s0.max; 

s0.reg(0, "../_SAMPLES/amen_kick.wav");
s0.reg(1, "../_SAMPLES/amen_snare.wav");
s0.reg(2, "../_SAMPLES/amen_snare2.wav");
s0.reg(3, "../_SAMPLES/amen_hit.wav");
//s0.reg("A", "../_SAMPLES/REGGAE_SET_1/Timbales1_Reaggae1.wav");

0 => s0.sync;
"*8 5n_n_nb _5___d p5666_dq_ d_d_ndn" => s0.seq; 
s0.post() => Gain mult => LPF lpf1 =>  dac; GVerb gverb0  => dac;

2974 => lpf1.freq;
.6 => lpf1.gain;
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
	  

2003 => lpf.freq;


"ddl43A|*3%" => ib.code;
Step stp => ib;
18 => stp.next;

4 => gverb0.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
.2::second => gverb0.revtime;   // revtime: (dur), default 5::second
0.99 => gverb0.dry;             // dry (float) [0.0 - 1.0], default 0.6                
0.9 => gverb0.early;           // early (float) [0.0 - 1.0], default 0.4
0.3 => gverb0.tail;            // tail (float) [0.0 - 1.0], default 0.5       

s0.go();
while(1) { 100::ms => now; }
//data.meas_size * data.tick => now; 
