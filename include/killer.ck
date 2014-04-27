public class killer {

		static end @ list [0];

		fun static void reg (end in) {
				0 => int inside;
				for (0 => int i; i < list.size()      ; i++) {
						if (in == list[i]) 1=> inside;
				}
				 
				if (!inside) {
						list << in;
						<<< in , "Registred in killer">>>;
				}
		}

		fun static void rem(int j) {
  		if (j < list.size()) {
				for (j => int i; i < list.size() - 1     ; i++) {
						list[j+1] @=> list[j];
				}
		
		    list.size() -1 => list.size;
		  }
		}


		fun static void kill_all() {
				for (0 => int i; i < list.size()      ; i++) {
					spork~list[i].kill_me_bad();	
			    rem(i);	
				}
				
		}

		fun static void kill(int id) {
				0=> int inside;
				for (0 => int i; i < list.size()      ; i++) {
					if (list[i].shred_id == id ) {
						spork~list[i].kill_me_bad();	
						rem(i);	
						1 => inside;
					}
				}

				if (!inside) {
						// not registered kill it directly
						Machine.remove(id);
				}
				
		}

}

end bar[0] @=> killer.list;


while(1) {
	     100::ms => now;
//			 killer.kill(3);
}
 
