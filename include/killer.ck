public class killer {

		static end @ list [0];

		fun static void reg (end @ in) {
				0 => int inside;
				for (0 => int i; i < list.size()      ; i++) {
						if (in.shred_id == list[i].shred_id) 1=> inside;
				}
				 
				if (!inside) {
						list << in;
						<<< in.shred_id , "Registred in killer">>>;
				
            //print_list();
        }
		}

		fun static void rem(int j) {
      //<<<"Before Remove: ", j>>>;
      //print_list();

  		if (j < list.size()) {
				for (j => int i; i < list.size() - 1     ; i++) {
						list[i+1] @=> list[i];
				}
		
		    list.size() -1 => list.size;
		  }
      //<<<"After Remove">>>;
      //print_list();
		}


		fun static void kill_all() {
				for (0 => int i; i < list.size()      ; i++) {
					spork~list[i].kill_me_bad();	
			    rem(i);	
				}
				
		}

		fun static void kill(int id) {
			//<<<"attempt to kill", id>>>; 
				0=> int inside;
        end @ e;
				for (0 => int i; i < list.size()      ; i++) {
					if (list[i].shred_id == id ) {
						//<<<"kill", id>>>;
						list[i] @=> e;	
						rem(i);	
						spork~e.kill_me_bad();	

						1 => inside;
					}
				}

				if (!inside) {
						<<< id,  "not registered kill it directly">>>;
						Machine.remove(id);
				}
				
		}

    fun static void print_list() {
      <<<"KILLER size: ", list.size(), " list:">>>;
      for (0 => int i; i <  list.size(); i++) {
        <<<i, list[i].shred_id>>>;
      }
    }


}

end bar[0] @=> killer.list;


while(1) {
	     100::ms => now;
//			 killer.kill(3);
}
 
