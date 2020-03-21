public class STREC extends ST {
  Gain in[2];
  Gain out[2];
  out[0] => outl;
  out[1] => outr;

  in => out;

  fun void f1 ( dur d, string name, dur sync_dur, int no_sync ){ 
    // sync
    if ( !no_sync ){

      if (sync_dur == 0::ms)  {
        // sync on full seq
        d - ((now - data.wait_before_start)%d) => now;
      }
      else {
        sync_dur  - ((now - data.wait_before_start)%sync_dur) => now;
      }
    }

    <<<"********************">>>; 
    <<<"********************">>>; 
    <<<"***   REC       ****">>>; 
    <<<"********************">>>; 
    <<<"********************">>>; 

    in =>  WvOut2 w => blackhole;
    name => w.wavFilename;

    d => now ;

    <<<"********************">>>; 
    <<<"********************">>>; 
    <<<"***  END  REC   ****">>>; 
    <<<"********************">>>; 
    <<<"********************">>>; 

    w =< blackhole;

    1::ms => now;

  } 

  fun void connect(ST @ tone, dur d, string name,  dur sync_dur, int no_sync) {
    tone.left() => in[0];
    tone.right() => in[1];

    spork ~ f1 (d, name, sync_dur, no_sync );
  }
}

