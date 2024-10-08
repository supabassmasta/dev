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

class LOOP_DOUBLE_WAV extends ST {
	SndBuf2 buf;
	SndBuf2 buf2;
	SYNC sy;
	Shred start_id;
  0::ms => dur end_sync;

  1. => buf.gain;
  1. => buf2.gain;

	buf.chan(0) => ADSR al => outl;
	buf.chan(1)=> ADSR ar => outr;

	buf2.chan(0) =>  al;
	buf2.chan(1)=>  ar;

	fun void AttackRelease(dur a, dur r){
		al.set(a, 0::ms, 1., r);
		ar.set(a, 0::ms, 1., r);
	}
	
	AttackRelease(0::ms, 0::ms);

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



	fun void _start(dur synchro,   dur endsync){
		endsync => end_sync => the_end.sync;
		sy.sync(synchro);

		al.keyOn(); ar.keyOn(); 
    buf.length() / 2. => dur half_buf_length;
		(((now - data.wait_before_start) % half_buf_length )/1::samp)$ int => int loop_start;
    loop_start => buf.pos;

    // Wait end of buff before loop
    half_buf_length - loop_start*1::samp => now;

			while(1) {
				0 => buf2.pos;
				half_buf_length => now;
				0 => buf.pos;
				half_buf_length => now;
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


LOOP_DOUBLE_WAV l;
"../_SAMPLES/STUDIO/deep_glass/BamboosEcho_2Echo.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
l.AttackRelease(1::ms, 15 * 100::ms);
l.start(1::ms /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

while(1) {
       100::ms => now;
}
 
