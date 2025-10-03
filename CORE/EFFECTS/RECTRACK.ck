public class RECTRACK {
  // Public
  0 => int compute_mode; // play song with real computing
  0 => int rec_mode; // While playing song in compute mode, rec it

  "rec_default_name.wav" => string name_main;
  8 * data.tick => dur main_extra_time;
  8 * data.tick => dur end_loop_extra_time;
  1 * data.tick => dur play_end_sync;
//  1 * data.tick => dur end_loop_play_end_sync;

  // Private
  STREC strec;
  STREC strecendloop;
  STREC strecend;

  ST stmain;

  fun int play_or_rec () {
    WAIT w; 
    play_end_sync => w.sync_end_dur;

    if ( !compute_mode && MISC.file_exist(name_main) ){
      LONG_WAV l;
      name_main => l.read;
      1.0 * data.master_gain => l.buf.gain;
      0 => l.update_ref_time;
      l.AttackRelease(0::ms, 10::ms);
      l.start(0 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , play_end_sync /* END sync */); l $ ST @=> ST @ last;  

      // WAIT Main to finish
      l.buf.length() - main_extra_time  =>  w.wait;

      // END LOOP 
      ST stout;
      SndBuf2 buf_end_loop_0; name_main+"_end_loop" => buf_end_loop_0.read; buf_end_loop_0.samples() => buf_end_loop_0.pos; buf_end_loop_0.chan(0) => stout.outl; buf_end_loop_0.chan(1) => stout.outr;
      SndBuf2 buf_end_loop_1; name_main+"_end_loop" => buf_end_loop_1.read; buf_end_loop_1.samples() => buf_end_loop_1.pos; buf_end_loop_1.chan(0) => stout.outl; buf_end_loop_1.chan(1) => stout.outr;

      0 => int toggle;
      0 => data.next;

      while (!data.next) {
        <<<"**********">>>;
        <<<" END LOOP ">>>;
        <<<"**********">>>;
        if ( !toggle ) {
          1 => toggle;
          0 => buf_end_loop_0.pos;
        } else {
          0 => toggle;
          0 => buf_end_loop_1.pos;
        }
        // WAIT end loop to finish
        buf_end_loop_0.length() - end_loop_extra_time =>  w.wait;
      }

      // END
      SndBuf2 buf_end_0; name_main+"_end" => buf_end_0.read; buf_end_0.samples() => buf_end_0.pos; buf_end_0.chan(0) => stout.outl; buf_end_0.chan(1) => stout.outr;
      0 => buf_end_0.pos;
      buf_end_0.length() =>  w.wait;

      return 0;
    }
    else {
      // REC  MAIN OR PURE COMPUTE /////////////////////////////////////////     
      if (rec_mode) {     
        // Connect Main out for rec
        dac.left => stmain.outl;
        dac.right => stmain.outr;
        strec.connect(stmain $ ST);
        0 => strec.gain; // Avoid infinite sound loop on main out
        strec.rec_start(name_main, 0::ms, 1);
      }
      return 1;
    }

  }

  fun void rec_stop (){ 
    if (rec_mode) {     
      main_extra_time =>  now;  // Wait for Echoes REV to complete
      strec.rec_stop( 0::ms, 1);
      2::ms => now;
    }
  } 

  fun void  rec_end_loop  (){ 
    if (rec_mode) {     
      strecendloop.connect(stmain $ ST);
      0 => strecendloop.gain;
      strecendloop.rec_start(name_main +"_end_loop", 0::ms, 1);

      // As we are in rec mode, directly go out end loop
      1 => data.next;
    }
  } 

  fun void  stop_rec_end_loop(){ 
    if (rec_mode ) {     
      end_loop_extra_time =>  now;  // Wait for Echoes REV to complete
      strecendloop.rec_stop( 0::ms, 1);
      2::ms => now;
    }
     
  } 

  fun void  rec_end(){ 
    if (rec_mode) {
      strecend.connect(stmain $ ST);
      0 => strecend.gain;
      strecend.rec_start(name_main +"_end", 0::ms, 1);
    }
  } 

  fun void stop_rec_end(){ 
    if (rec_mode) {     
      strecend.rec_stop( 0::ms, 1);
      2::ms => now;
    }
  } 


}

