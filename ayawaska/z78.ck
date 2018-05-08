class SYNC {

	fun void sync (dur d){
		d - ((now - data.wait_before_start)%d) => now;
	}

}


class LONG_WAV extends ST {
	SndBuf buf;
	SYNC sy;
  0 => int update_ref_time; 

  .5 => buf.gain;

	buf => outl;
	buf => outr;

	fun void read(string in) {
		buf.samples() => buf.pos;
		in => buf.read;
	}


	fun void _start(dur synchro, dur offset, dur loop){
		sy.sync(synchro);

		(offset/1::samp) $ int => buf.pos;
		if (update_ref_time){
		  MASTER_SEQ3.update_ref_times(now, data.tick * 16 * 128 );
		}

		if (loop != 0::ms) {
			while(1) {
				loop => now;
				// restart to offset
				(offset/1::samp) $ int => buf.pos;
			}
 
		}

	}

	fun void start(dur synchro, dur offset, dur loop){
		spork ~ _start(synchro, offset, loop);
	}
}

LONG_WAV l;
"../_SAMPLES/Chassin/Icario chant G D C test2.wav" => l.read;
1 => l.update_ref_time;
l.start(4 * data.tick /* sync */ , 128 * data.tick + 32 * data.tick  /* offset */ , 16 * data.tick /* loop (0::ms == disable) */ );
//l.start(4 * data.tick, 0 * data.tick);

while(1) {
	     100::ms => now;
}
 
