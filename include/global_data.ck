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
// MIX
   static float master_gain;
   static float potar_synts_gain; // For micro trance


// EVENTS
   // Auto reset for super_seq
   static Event @ super_seq_reset_ev;
	 // Break events
   static Event @ break_ev[8];
//	 static int  break_state;
	 static int  break_state[];

// FRAMEWORK
    static dur wait_before_start;
		static time T0;

// Page manager
   static int page_manager_page_nb;
   static int page_manager_start_page;

// loop updater
  static int next;

}

now => data.T0;
<<<"data.T0" , data.T0>>>; 

500::ms => data.tick;
130 => data.bpm;
1. => data.master_gain;
1. => data.potar_synts_gain;

1000::ms=> data.wait_before_start;

new string_dummy @=> data.scale;

Event bar1 @=> data.super_seq_reset_ev;
//string bar2 @=> data.scale;

Event bar3[8] @=> data.break_ev;
[0, 0, 0, 0, 0, 0, 0, 0]  @=> data.break_state;

8 => data.page_manager_page_nb;
0 => data.page_manager_start_page;

0 => data.next;

while(1) 1000::ms => now;

