  class END extends end { 
		dur sync;
		ADSR @ al;
		ADSR @ ar;
    10::ms => dur rDur;
    fun void kill_me () {
			SYNC sy;

			if (sync == 0::ms) {
				<<<"END LONG WAV NO SYNC">>>; 
				al.keyOff(); ar.keyOff();  
				rDur => now;
				<<<"REAL END LONG WAV">>>; 
			}
			else {
				<<<"END LONG WAV SYNC">>>; 
        sy.sync(sync ,-1* rDur);
				al.keyOff(); ar.keyOff();  
				rDur => now;
				<<<"REAL END LONG WAV">>>; 
			}
    }
  }; 

public class LONG_WAV extends ST {
	SndBuf2 buf;
	SYNC sy;
  0 => int update_ref_time; 
	Shred start_id;
  0::ms => dur end_sync;
  10::ms => dur rDur;

  1. => buf.gain;
  0=> int stop_counter;

	buf.chan(0) => ADSR al => outl;
	buf.chan(1)=> ADSR ar => outr;


	fun void read(string in) {
		in => buf.read;
		buf.samples() => buf.pos;
	}

  END the_end;   
	end_sync => the_end.sync;
	al @=> the_end.al;
	ar @=> the_end.ar;

	fun void AttackRelease(dur a, dur r){
		al.set(a, 0::ms, 1., r);
		ar.set(a, 0::ms, 1., r);
    r => the_end.rDur;
    r => rDur;
	}
	
	AttackRelease(0::ms, 0::ms);



	fun void _start(dur synchro, dur offset, dur loop, dur endsync){
		endsync => end_sync => the_end.sync;
		sy.sync(synchro);

		al.keyOn(); ar.keyOn(); 
		(offset/1::samp) $ int => buf.pos;
		if (update_ref_time){
		  MASTER_SEQ3.update_ref_times(now, data.tick * 16 * 128 );
		}
    
    stop_counter => int local_stop_counter;
		
    if (loop != 0::ms) {
			while(stop_counter == local_stop_counter) {
				loop => now;
				// restart to offset
        if (stop_counter == local_stop_counter)
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

 fun void _stop () {
				al.keyOff(); ar.keyOff();  
				rDur => now;
     		buf.samples() => buf.pos;
        1 +=> stop_counter;
}
 fun void stop () {
    spork ~ _stop();
 }
//  Machine.remove(start_id.id());


}
