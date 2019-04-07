  class END extends end { 
		dur sync;
		ADSR @ al;
		ADSR @ ar;
    fun void kill_me () {
			SYNC sy;

			if (sync == 0::ms) {
				<<<"END LOOP WAV NO SYNC">>>; 
				al.keyOff(); ar.keyOff();  
				al.releaseTime() => now;
				<<<"REAL END LOOP WAV">>>; 
			}
			else {
				<<<"END LOOP WAV SYNC">>>; 
        sy.sync(sync ,-1* al.releaseTime());
				al.keyOff(); ar.keyOff();  
				al.releaseTime() => now;
				<<<"REAL END LOOP WAV">>>; 
			}
    }
  }; 

public class LOOP_WAV extends ST {
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



	fun void _start(dur synchro,   dur endsync){
		endsync => end_sync => the_end.sync;
		sy.sync(synchro);

		al.keyOn(); ar.keyOn(); 
		(((now - data.wait_before_start)%buf.length())/1::samp)$ int => int loop_start;
    loop_start => buf.pos;

    // Wait end of buff before loop
    buf.length() - loop_start*1::samp => now;

			while(1) {
				0 => buf.pos;
				buf.length() => now;
			}
 

	}

	fun void start(dur synchro,   dur endsync){
		spork ~ _start(synchro,  endsync) @=> start_id;

    // Get id from caller shred
    me.id() => the_end.shred_id;
    //  register end
    killer.reg(the_end);
	}

}


