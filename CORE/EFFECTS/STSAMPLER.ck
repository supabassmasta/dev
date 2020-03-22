public class STSAMPLER extends ST {
  Gain in[2];
  Gain out[2];
  Delay del[2];
  out[0] => outl;
  out[1] => outr;

  string path;
  string name;

  in => out;
  in => del => blackhole;
  1. => del[0].gain => del[1].gain;

  fun void f1 ( dur d, dur sync_dur, int no_sync ){ 

    // get file index
    SAVE sav;
    "." => sav.dir; // save index in current directory
    "sampler_index_" + name => string fname;
    sav.readi(fname) => int findex;
    findex + 1 => findex;
    sav.savei(fname, findex);


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
    path + name + findex + ".wav" => w.wavFilename;

    d => now ;
    w =< blackhole;

    del => del;
    del => out;
    in[0] =< del[0];
    in[1] =< del[1];
    in[0] =< out[0];
    in[1] =< out[1];
    del[0] =< blackhole;
    del[1] =< blackhole;

    <<<"********************">>>; 
    <<<"********************">>>; 
    <<<"***  END  REC   ****">>>; 
    <<<"********************">>>; 
    <<<"********************">>>; 


    1::ms => now;

  } 

  fun void connect(ST @ tone, dur d, string p, string n,  dur sync_dur, int no_sync) {
    tone.left() => in[0];
    tone.right() => in[1];

    d => del[0].max => del[0].delay => del[1].max => del[1].delay;

    p => path;
    n => name;

    spork ~ f1 (d, sync_dur, no_sync );
  }
}

