public class end  {

 int shred_id;

 fun void kill_me () {}

 fun void kill_me_bad	() {
				kill_me();
			  <<<"now removing :", shred_id >>>;	
				Machine.remove(shred_id);

	 }	


	}

