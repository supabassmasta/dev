class SYNC {

	fun void sync (dur d){
		d - ((now - data.wait_before_start)%d) => now;
	}

}


class LONG_WAV extends ST {
	SndBuf buf;
	SYNC sy;
	44100 => int srate;

  .5 => buf.gain;

	buf => outl;
	buf => outr;

	fun void read(string in) {
		buf.samples() => buf.pos;
		in => buf.read;
	}


	fun void start(dur synchro, dur offset){
		sy.sync(synchro);

		(offset/1::samp) $ int => buf.pos;


	}

}

LONG_WAV l;
"../_SAMPLES/Chassin/Icario chant G D C test2.wav" => l.read;
l.start(4 * data.tick, 128 * data.tick);

while(1) {
	     100::ms => now;
}
 
