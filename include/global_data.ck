class string_dummy
{
    string my_string;
}


public class data {

// RYTHM
    static float bpm;
    static dur tick;
		static int meas_size;
// SCALE, NOTES...
    static string_dummy @ scale; 
    static int ref_note;


// EVENTS
   // Auto reset for super_seq
   static Event @ super_seq_reset_ev;
	 // Break events
   static Event @ break_ev[8];
//	 static int  break_state;
	 static int  break_state[];

// FRAMEWORK
    static dur wait_before_start;


}
500::ms => data.tick;
130 => data.bpm;
1000::ms=> data.wait_before_start;

new string_dummy @=> data.scale;

Event bar1 @=> data.super_seq_reset_ev;
//string bar2 @=> data.scale;

Event bar3[8] @=> data.break_ev;
[0, 0, 0, 0, 0, 0, 0, 0]  @=> data.break_state;

while(1) 1000::ms => now;

