class cont extends CONTROL {
     Event @ e;

     // 0 =>  update_on_reg ;
        fun void set(float in) {
          if ( in !=0  ){
              e.signal();
          }
        }
} 


// Used to load previous sample. On Sampler start the last one is loaded.
class cont_retro_index extends CONTROL {
     0 => int retro_index_offset;

     // 0 =>  update_on_reg ;
        fun void set(float in) {
          if ( in !=0  ){
            1 -=> retro_index_offset;
          }
        }
} 

public class STSAMPLERC extends ST {
  Gain in[2];
  Gain out[2];
  out[0] => outl;
  out[1] => outr;

  186::ms => dur latency;
  0::ms => dur rec_dur;
  1 => int loop_playback;

  string path;
  string name;
  
  int file_nb, file_x, file_y;
  Event rec_e;
  Event play_e;

  cont cont_rec;
  rec_e @=> cont_rec.e;

  cont cont_play;
  play_e @=> cont_play.e;

  cont_retro_index cont_retro_index_o;

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

      COUNTDOWN countdown;
      countdown.start(sync_dur, 1*data.tick); 

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
      
      if (rec_dur == 0::ms) {
        // Wait event to stop
        rec_e => now;     
        HW.launchpad.color(16*(file_x+1) + file_y ,53);

        COUNTDOWN countdown;
        countdown.start(sync_dur, 1*data.tick); 

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
      }
      else {
        rec_dur => now;   
      }
      // Wait latency to get a full loop (As latency duration will be skipped on playback at the begining)
      latency => now; 

      w =< blackhole;{
        if (sync_dur == 0::ms)  {
          // sync on full seq
          <<<"ERROR STSAMPLERC NO Sync on full dur">>>;
        }
        else {
          sync_dur  - ((now - data.wait_before_start)%sync_dur) => now;
        }
      }

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

      // Manage retro index
      findex + cont_retro_index_o.retro_index_offset => findex;
      if (findex < 0) 0 => findex;

      path + name + "_z" + file_nb + "_" + findex  + ".wav" => fname;
      
      <<<"STSAMPLREC: playing:", fname>>>;

      fname => l.read;
      1.0 * data.master_gain => l.buf.gain;
      0 => l.update_ref_time;
      l.AttackRelease(0::ms, 0::ms);

      0::ms => dur loopd;
      if (loop_playback) l.buf.length() - latency =>  loopd;

      spork ~ l._start(sync_dur /* sync */ , latency  /* offset */ , loopd /* loop (0::ms == disable) */ , sync_dur/* END sync */); l $ ST @=> ST @ last;  
      

      play_e => now;     
      l.stop();
      HW.launchpad.color(16*(file_x+2) + file_y ,44);
    }

  }

  fun void connect(ST @ tone,  string p, string n,  dur sync_dur, dur d, int loop, int no_sync, dur lat, string script_path) {
    // sync_dur is used to sync: start rec, stop rec, start play, stop play
    tone.left() => in[0];
    tone.right() => in[1];

    p => path;
    n => name;
    d => rec_dur;
    loop => loop_playback;
    lat => latency;
    
    //<<<"PATH:: ", me.path()>>>;
    MISC.file_nb(script_path) => file_nb;

    // Compute coordinate on launchpad
    file_nb/ 10 -1 => file_x;
    file_nb%10 -1 =>  file_y;

    // REC button
    HW.launchpad.color(16*(file_x+1) + file_y ,52);
    HW.launchpad.keys[ 16*(file_x+1) + file_y].reg(cont_rec);

    // play button
    HW.launchpad.color(16*(file_x+2) + file_y ,44);
    HW.launchpad.keys[ 16*(file_x+2) + file_y].reg(cont_play);

    // Retro index
    // Used to load previous sample. On Sampler start the last one is loaded.
    HW.launchpad.color(16*(file_x+3) + file_y ,44);
    HW.launchpad.keys[ 16*(file_x+3) + file_y].reg(cont_retro_index_o);


    spork ~ f1 (sync_dur, no_sync );
    spork ~   play (sync_dur, no_sync );

  }
}
