  class END extends end { 
		dur sync;
		ADSR @ al;
		ADSR @ ar;
    10::ms => dur rDur;
    fun void kill_me () {
			SYNC sy;

			if (sync == 0::ms) {
				<<<"END LOOP WAV NO SYNC">>>; 
				al.keyOff(); ar.keyOff();  
				rDur => now;
				<<<"REAL END LOOP WAV">>>; 
			}
			else {
				<<<"END LOOP WAV SYNC">>>; 
        sy.sync(sync ,-1* rDur);
				al.keyOff(); ar.keyOff();  
				rDur => now;
				<<<"REAL END LOOP WAV">>>; 
			}
    }
  }; 

public class LOOP_DOUBLE_WAV_SYNC extends ST {
	SndBuf2 buf;
	SndBuf2 buf2;
	SYNC sy;
	Shred start_id;
  0::ms => dur end_sync;
  10::ms => dur rDur;

  1. => buf.gain;
  1. => buf2.gain;

	buf.chan(0) => ADSR al => outl;
	buf.chan(1)=> ADSR ar => outr;

	buf2.chan(0) =>  al;
	buf2.chan(1)=>  ar;

	fun void read(string in) {
		in => buf.read;
		in => buf2.read;
		buf.samples() => buf.pos;
		buf2.samples() => buf2.pos;
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


	fun void _start(dur synchro,   dur endsync, dur loop){
		endsync => end_sync => the_end.sync;
		sy.sync(synchro);

		al.keyOn(); ar.keyOn(); 
		(((now - data.wait_before_start) % loop )/1::samp)$ int => int loop_start;
    loop_start => buf.pos;

    // Wait end of buff before loop
    buf.length() - loop_start*1::samp => now;

		while(1) {
			0 => buf2.pos;
			loop => now;
			0 => buf.pos;
			loop => now;
		}
 

	}

	fun void start(dur synchro,   dur endsync, dur loop){
		spork ~ _start(synchro,  endsync, loop) @=> start_id;

    // Get id from caller shred
    me.id() => the_end.shred_id;
    //  register end
    killer.reg(the_end);
	}

}


