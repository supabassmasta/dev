public class REC extends ST{

  fun void rec (dur d, string name, dur sync_dur) {
    // sync
    if (sync_dur == 0::ms)  {
      // sync on full seq
      d - ((now - data.wait_before_start)%d) => now;
    }
    else {
      sync_dur  - ((now - data.wait_before_start)%sync_dur) => now;
    }

		<<<"********************">>>; 
		<<<"********************">>>; 
		<<<"***   REC       ****">>>; 
		<<<"********************">>>; 
		<<<"********************">>>; 


    dac => WvOut2 w => blackhole;
    name => w.wavFilename;


    d => now ;
		
		<<<"********************">>>; 
		<<<"********************">>>; 
		<<<"***  END  REC   ****">>>; 
		<<<"********************">>>; 
		<<<"********************">>>; 
    
		w =< blackhole;
    dac =< w;

    1::ms => now;
  }

  fun void rec_no_sync (dur d, string name) {

		<<<"********************">>>; 
		<<<"********************">>>; 
		<<<"***   REC       ****">>>; 
		<<<"********************">>>; 
		<<<"********************">>>; 


    dac => WvOut2 w => blackhole;
    name => w.wavFilename;


    d => now ;
		
		<<<"********************">>>; 
		<<<"********************">>>; 
		<<<"***  END  REC   ****">>>; 
		<<<"********************">>>; 
		<<<"********************">>>; 
    
		w =< blackhole;
    dac =< w;
    1::ms => now;
  }
}
