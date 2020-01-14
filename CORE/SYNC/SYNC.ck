public class SYNC {

	fun void sync (dur d){
		d - ((now - data.wait_before_start)%d) => now;
	}

	fun void sync (dur d, dur offset){
		d - ((now - (data.wait_before_start + offset))%d)  => now;
	}

}


