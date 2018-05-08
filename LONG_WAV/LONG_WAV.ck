public class LONG_WAV extends ST {
	SndBuf2 buf;
	SYNC sy;
  0 => int update_ref_time; 
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
		buf.samples() => buf.pos;
		in => buf.read;
	}

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
  END the_end;   
	end_sync => the_end.sync;
	al @=> the_end.al;
	ar @=> the_end.ar;



	fun void _start(dur synchro, dur offset, dur loop, dur endsync){
		endsync => end_sync => the_end.sync;
		sy.sync(synchro);

		al.keyOn(); ar.keyOn(); 
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

	fun void start(dur synchro, dur offset, dur loop, dur endsync){
		spork ~ _start(synchro, offset, loop, endsync) @=> start_id;

    // Get id from caller shred
    me.id() => the_end.shred_id;
    //  register end
    killer.reg(the_end);
	}


//  Machine.remove(start_id.id());


}
