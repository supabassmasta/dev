public class seq_script extends seq {


	string path;
		int shred_id;
    1 => int remove_on;
		// Private
		0 => int note_on;


		fun void read(string s){
				s => path;
		}





    fun void start_note(int i){
        start_ev.broadcast();
				if (g[i%g.size()] == 1.) {
						if (! remove_on){
//							<<<"ADD 0">>>;
							Machine.add (path) => shred_id;
						}
						else if (!note_on){
								1 => note_on;
							Machine.add (path) => shred_id;
//							<<<"ADD 1", shred_id>>>;
						}
				} 
				else if (g[i%g.size()] != 0.){
						if (! remove_on){
							Machine.add (path + ( g[i%g.size()] $ int )) => shred_id;
//							<<<"ADD 2">>>;
						}
						else if (!note_on){
								1 => note_on;
						   <<<"ERROR: Multi mode not available in remove_on mode !!">>>;	
						}
					
				}
//				 <<<"start_note", i>>>;
        }
    fun void stop_note(int i){
        stop_ev.broadcast();
//				<<<"TRACE", remove_on, g[(i+1)%g.size()]>>>; 
				if (remove_on){
						if (g[(i+1)%g.size()] == 0.) {
								killer.kill(shred_id);
								0 => note_on;
						}
				}
//        <<<"stop_note",i>>>;
        }

}
