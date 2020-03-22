STMIX stmix;
//stmix.send(last, 11);
stmix.receive(58); stmix $ ST @=> ST @ last; 

class STSAMPLER extends ST {
  Gain in[2];
  Gain out[2];
  Delay del[2];
  out[0] => outl;
  out[1] => outr;

  in => out;
  in => del => blackhole;
  1. => del[0].gain => del[1].gain;

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

  fun void connect(ST @ tone, dur d, string name,  dur sync_dur, int no_sync) {
    tone.left() => in[0];
    tone.right() => in[1];

    d => del[0].max => del[0].delay => del[1].max => del[1].delay;


    spork ~ f1 (d, name, sync_dur, no_sync );
  }
}

STSAMPLER stsampler;
stsampler.connect(last $ ST, 8*data.tick, "samp1.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); stsampler $ ST @=>  last; 


STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
