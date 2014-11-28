fun void f1 (){ 
	 <<<"id_in", me.id()>>>;
		100::ms => now;
	 } 
	 (spork ~ f1 ()).id() => int id_out;
	 <<<"id_out", id_out>>>;
		100::ms => now;
	  
