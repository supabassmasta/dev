public class DUCK extends Chubgraph {

		inlet => Envelope e => outlet;
		1. => e.value;

		3::ms => dur attack;
		10::ms => dur decay;
		.2 => float remaining;
		4::ms => dur release;

		fun void set(dur a, dur d, float rem, dur rel) {
				a => attack;
				d => decay;
				rem => remaining;
				rel => release;
		}

		fun void f1 (){ 
				while(1) {
						DUCK_MASTER.ev => now;
						
						attack => e.duration;
						remaining => e.target;

						attack => now;
						
						decay => now;

						release => e.duration;
						1. => e.target;

				}
				 
			 } 
			 spork ~ f1 ();
			  



}
