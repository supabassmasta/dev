public class DUCK_MASTER {

   static Event @ ev;

		
fun static void set() {
		ev.broadcast();
}

fun static void auto_exec (){ 

 data.tick - (now - data.wait_before_start) % ( data.tick) => now ;
 
 while(1) {
		ev.broadcast();
		data.tick => now;
	}
 
} 
	  
fun static void auto () {
		
	 spork ~ auto_exec  ();

}

}
Event dummy_ev124 @=> DUCK_MASTER.ev ;

while(1) 1000::ms => now;
