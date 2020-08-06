public class end  {

 int shred_id;
 NULL @=> end @ next; 
 0 => int no_remove;
 0 => int no_replace;

 fun void kill_me () {}

 fun void kill_me_bad	() {
				kill_me();
        if ( ! no_remove  ){
          <<<"now removing :", shred_id >>>;	
          Machine.remove(shred_id);
        }

	 }	


	}

