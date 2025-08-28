public class RECSEQ {
  // Public
  0 => int compute_mode; // play song with real computing
  0 => int rec_mode; // While playing song in compute mode, rec it

  "rec_default_name.wav" => string name_main;
  8 * data.tick => dur main_extra_time;

  WAIT w; // To be configured on instance, if sync end is required when playback
  1::samp => w.fixed_end_dur;

  // Private
  STREC strec;
  ST stmain;

  fun int play_or_rec () {
    if ( !compute_mode && MISC.file_exist(name_main) ){
      LONG_WAV l;
      name_main => l.read;
      1.0 * data.master_gain => l.buf.gain;
      0 => l.update_ref_time;
      l.AttackRelease(0::ms, 10::ms);
      l.start(0 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 1 * data.tick /* END sync */); l $ ST @=> ST @ last;  

      // WAIT Main to finish
      l.buf.length()   =>  w.wait;

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
      main_extra_time =>  w.wait;  // Wait for Echoes REV to complete
      strec.rec_stop( 0::ms, 1);
      2::ms => now;
    }
  } 
}

