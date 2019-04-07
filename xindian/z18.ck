  class END extends end { 
		dur sync;
		ADSR @ al;
		ADSR @ ar;
    fun void kill_me () {
			SYNC sy;

			if (sync == 0::ms) {
				<<<"END LONG WAV NO SYNC">>>; 
				al.keyOff(); ar.keyOff();  
				al.releaseTime() => now;
				<<<"REAL END LONG WAV">>>; 
			}
			else {
				<<<"END LONG WAV SYNC">>>; 
        sy.sync(sync ,-1* al.releaseTime());
				al.keyOff(); ar.keyOff();  
				al.releaseTime() => now;
				<<<"REAL END LONG WAV">>>; 
			}
    }
  }; 

class LOOP_WAV extends ST {
	SndBuf2 buf;
	SYNC sy;
	Shred start_id;
  0::ms => dur end_sync;

  1. => buf.gain;

	buf.chan(0) => ADSR al => outl;
	buf.chan(1)=> ADSR ar => outr;

	fun void AttackRelease(dur a, dur r){
		al.set(a, 0::ms, 1., r);
		ar.set(a, 0::ms, 1., r);
	}
	
	AttackRelease(0::ms, 0::ms);

	fun void read(string in) {
		in => buf.read;
		buf.samples() => buf.pos;
	}

  END the_end;   
	end_sync => the_end.sync;
	al @=> the_end.al;
	ar @=> the_end.ar;



	fun void _start(dur synchro, dur offset,  dur endsync){
		endsync => end_sync => the_end.sync;
		sy.sync(synchro);

		al.keyOn(); ar.keyOn(); 
		(((now - data.wait_before_start)%buf.length())/1::samp) $ int => buf.pos;
//		(offset/1::samp) $ int => buf.pos;

			while(1) {
				buf.length() => now;
				// restart to offset
				(offset/1::samp) $ int => buf.pos;
			}
 

	}

	fun void start(dur synchro, dur offset,  dur endsync){
		spork ~ _start(synchro, offset,  endsync) @=> start_id;

    // Get id from caller shred
    me.id() => the_end.shred_id;
    //  register end
    killer.reg(the_end);
	}

}


LOOP_WAV l;
"loop.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
l.AttackRelease(1::ms, 100::ms);
l.start(1 * data.tick /* sync */ , 0 * data.tick  /* offset */ ,  1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
