class cont extends CONTROL {
     Event @ e;

     // 0 =>  update_on_reg ;
        fun void set(float in) {
          if ( in !=0  ){
              e.signal();
          }
        }
} 

class STSAMPLERC extends ST {
  Gain in[2];
  Gain out[2];
  out[0] => outl;
  out[1] => outr;

  186::ms => dur latency;

  string path;
  string name;
  
  int file_nb, file_x, file_y;
  Event rec_e;
  Event play_e;

  cont cont_rec;
  rec_e @=> cont_rec.e;

  cont cont_play;
  play_e @=> cont_play.e;


  fun void f1 ( dur sync_dur, int no_sync ){ 

    // get file index
    SAVE sav;
    "." => sav.dir; // save index in current directory
    "sampler_index_" + name + "_z" + file_nb => string fname;
    
//    while(1) {

      // Wait event to start
      rec_e => now;     

      HW.launchpad.color(16*(file_x+1) + file_y ,53);

      sav.readi(fname) => int findex;
      findex + 1 => findex;
      sav.savei(fname, findex);

      // sync
      if ( !no_sync ){
        if (sync_dur == 0::ms)  {
          // sync on full seq
          <<<"ERROR STSAMPLERC NO Sync on full dur">>>;
        }
        else {
          sync_dur  - ((now - data.wait_before_start)%sync_dur) => now;
        }
      }

      HW.launchpad.red(16*(file_x+1) + file_y);


      <<<"********************">>>; 
      <<<"********************">>>; 
      <<<"***   REC       ****">>>; 
      <<<"********************">>>; 
      <<<"********************">>>; 

      in =>  WvOut2 w => blackhole;
      path + name + "_z" + file_nb + "_" + findex + ".wav" => w.wavFilename;

      // Wait event to stop
      rec_e => now;     
      HW.launchpad.color(16*(file_x+1) + file_y ,53);

      // sync
      if ( !no_sync ){
        if (sync_dur == 0::ms)  {
          // sync on full seq
          <<<"ERROR STSAMPLERC NO Sync on full dur">>>;
        }
        else {
          sync_dur  - ((now - data.wait_before_start)%sync_dur) => now;
        }
      }

      // Wait latency to get a full loop (As latency duration will be skipped on playback at the begining)
      latency => now; 


      w =< blackhole;

      <<<"********************">>>; 
      <<<"********************">>>; 
      <<<"***  END  REC   ****">>>; 
      <<<"********************">>>; 
      <<<"********************">>>; 
      HW.launchpad.color(16*(file_x+1) + file_y ,52);


      1::ms => now;
//    }

  } 

  fun void play ( dur sync_dur, int no_sync ){ 
      LONG_WAV l;
      l.left() => outl;
      l.right() => outr;
    
    while(1) {

      play_e => now;     

      HW.launchpad.green(16*(file_x+2) + file_y);

      // get file index
      SAVE sav;
      "." => sav.dir; // save index in current directory
      "sampler_index_" + name  + "_z" + file_nb => string fname;
      sav.readi(fname) => int findex;
      path + name + "_z" + file_nb + "_" + findex  + ".wav" => fname;
      
      <<<"STSAMPLREC: playing:", fname>>>;

      fname => l.read;
      1.0 * data.master_gain => l.buf.gain;
      0 => l.update_ref_time;
      l.AttackRelease(0::ms, 0::ms);
      spork ~ l._start(sync_dur /* sync */ , latency  /* offset */ , l.buf.length() /* loop (0::ms == disable) */ , sync_dur/* END sync */); l $ ST @=> ST @ last;  
      

      play_e => now;     
      l.stop();
      HW.launchpad.color(16*(file_x+2) + file_y ,44);
    }

  }

  fun void connect(ST @ tone,  string p, string n,  dur sync_dur, int no_sync) {
    // sync_dur is used to sync: start rec, stop rec, start play, stop play
    tone.left() => in[0];
    tone.right() => in[1];

    p => path;
    n => name;

    MISC.file_nb(me.path()) => file_nb;

    // Compute coordinate on launchpad
    file_nb/ 10 -1 => file_x;
    file_nb%10 -1 =>  file_y;

    // REC button
    HW.launchpad.color(16*(file_x+1) + file_y ,52);
    HW.launchpad.keys[ 16*(file_x+1) + file_y].reg(cont_rec);

    // play button
    HW.launchpad.color(16*(file_x+2) + file_y ,44);
    HW.launchpad.keys[ 16*(file_x+2) + file_y].reg(cont_play);


    spork ~ f1 (sync_dur, no_sync );
    spork ~   play (sync_dur, no_sync );

  }
}

class STADC1 extends ST{
  Gain gainl => outl;
  Gain gainr => outr;

  1. => gainl.gain => gainr.gain;

  adc => gainl;
  adc => gainr;

}

STADC1 stadc1; stadc1 $ ST @=>  ST @ last; 


STSAMPLERC stsamplerc;
stsamplerc.connect(last $ ST,  "./" /* path for wav */,  "sample" /* wav name, /!\ NO EXTENSION */, 8 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); stsamplerc $ ST @=>  last;  

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 9/* ir index */, 2 /* chans */, 10::ms /* pre delay*/, .08 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
