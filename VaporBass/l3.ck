
class conv extends Chugen {

		float resp[0];
		float buf[0];
		0 => int idx;

    fun float tick(float in)
    {
				0. => float res;
				0. => float ponder;
				if (resp.size() == 0)
					return in;	
				else {
					in => buf[idx];
					idx ++; if (idx >= buf.size()) 0=> idx;

				  for (0 => int i; i < resp.size() ; i++) {
							resp[i] * buf[ (i + idx) % buf.size() ] +=> res;	
							resp[i] +=> ponder; 
					}
					 
				  return res / ponder;

				}
	  }

}



SEQ_STR s0; // 4 => s0.max; 0 => s0.sync;

s0.reg(0, "../_SAMPLES/amen_kick.wav");
s0.reg(1, "../_SAMPLES/amen_snare.wav");
s0.reg(2, "../_SAMPLES/amen_snare2.wav");
s0.reg(3, "../_SAMPLES/amen_hit.wav");
//s0.reg("A", "../_SAMPLES/REGGAE_SET_1/Timbales1_Reaggae1.wav");

"*4 5__e__n_"  => s0.seq;
s0.post() => conv c =>  dac;


		c.resp << 1.; 

for (0 => int i; i < 20      ; i++) {
//		c.resp << (30 - i) $ float;
		c.resp << 0.; 
}

		c.resp << 1.; 
 
c.resp.size() => c.buf.size;

s0.go();
while(1) { 100::ms => now; }
//data.meas_size * data.tick => now; 
