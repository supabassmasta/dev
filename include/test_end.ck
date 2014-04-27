

class END extends end { fun void kill_me () {
		<<<"THE END">>>; 	
		1500::ms => now;	
		<<<"THE real END">>>; 	
}}; END the_end; me.id() => the_end.shred_id; killer.reg(the_end); 




while(1) {
	     2000::ms => now;
	killer.kill(me.id());
}
 
