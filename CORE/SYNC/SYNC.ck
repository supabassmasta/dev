public class SYNC {

	fun void sync (dur d){
    if (d != 0::ms) {
		  d - ((now - data.wait_before_start)%d) => now;
    }
	}

	fun void sync (dur d, dur offset){
    if (d != 0::ms) {
		  d - ((now - (data.wait_before_start + offset))%d)  => now;
    }
	}

}


