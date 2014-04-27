public class killer {

		static Object @ list [0];

		fun static void reg (Object in) {
				0 => int inside;
				for (0 => int i; i < list.size()      ; i++) {
						if (in == list[i]) 1=> inside;
				}
				 
				if (!inside) {
						list << in;
						<<< in , "Registred in killer">>>;
				}
		}



}

Object bar[0] @=> killer.list;


while(1) {
	     100::ms => now;
}
 
