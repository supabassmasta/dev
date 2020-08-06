public class killer {

		static end @ list [0];

		fun static void reg (end @ in) {
				0 => int inside;
        end @ e;
        1 => int pos;
				for (0 => int i; i < list.size()      ; i++) {
						if (in.shred_id == list[i].shred_id) {
              1=> inside;

              // Shred already have end(s) registered
              list[i] @=> e;
              while(e.next != NULL) {
                e.next @=> e;
                1 +=> pos;
              }
              in @=> e.next; 
              <<< in.shred_id , "Registred in killer, sub end, position: ", pos>>>;
            }
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
        0 => int pos;

        1 => int not_removed;

				for (0 => int i; i < list.size()      ; i++) {

					if (list[i].shred_id == id ) {
						<<<"kill", id>>>;
						list[i] @=> e;	

            if (!e.no_remove) {
              0 => not_removed;
            }

						rem(i);	
						spork~e.kill_me_bad();	
            // kill sub end in same shred
            while(e.next != NULL) {
              e.next @=> e;
              
              if (!e.no_remove) {
                0 => not_removed;
              }
              
              spork~e.kill_me_bad();
              1 +=> pos;
              <<<"Kill sub end, id: ", id, " position: ", pos>>>;
            }

						1 => inside;
					}
				}

				if (!inside || not_removed) {
						<<< id,  "not registered or not removed, kill it directly">>>;
						Machine.remove(id);
				}
				
		}

    fun static void print_list() {
      <<<"KILLER size: ", list.size(), " list:">>>;
      for (0 => int i; i <  list.size(); i++) {
        <<<i, list[i].shred_id>>>;
      }
    }

		fun static int no_replace(int id) {
      0 => int no;
      end @ e;

      for (0 => int i; i < list.size()      ; i++) {
        //  <<<"no rep zid: ",list[i].shred_id, list[i].no_replace >>>;
        if (list[i].shred_id == id ) {
          list[i] @=> e;	

          if ( e.no_replace  ){
            1 => no;
            break;
          }
          while(e.next != NULL) {
            e.next @=> e;
            if ( e.no_replace  ){
              1 => no;
              break;
            }
          }

        }
      }
      //<<<"NO REPLACE STATUS:", no>>>;

      return no;
    }

}

end bar[0] @=> killer.list;


while(1) {
	     100::ms => now;
//			 killer.kill(3);
}
 
