// PLAY ONLY, REC in l32.ck

150 => data.bpm;   (60.0/data.bpm)::second => data.tick;
52 => data.ref_note;
"aeo" => data.scale.my_string;


/// PLAY OR REC /////////////////
RECTRACK rectrack; "l32.wav"=>rectrack.name_main; 0=>rectrack.compute_mode; 0=>rectrack.rec_mode;8*data.tick=>rectrack.main_extra_time;8*data.tick=>rectrack.end_loop_extra_time;
// w.the_end.sync_dur=>rectrack.play_end_sync;  // use the same end sync as in the track
if (rectrack.play_or_rec() ) {
  //////////////////////////////////

  //////////////////////////////////////////////////
  // MAIN 
  //////////////////////////////////////////////////

  //  !!!!!!  Put main code here  !!!!!


  //// STOP REC ///////////////////////////////
  rectrack.rec_stop();
  //////////////////////////////////////////////////

  ///////////////////////// END LOOP ///////////////////////////////////::
  0 => data.next;
  while (!data.next) {
    <<<"**********">>>;
    <<<" END LOOP ">>>;
    <<<"**********">>>;
    // REC END LOOP //////////////////////////////////
    rectrack.rec_end_loop();
    //////////////////////////////////////////////////

    // !!!!!! Put end loop here  !!!!!!

    //// STOP REC ///////////////////////////////
    rectrack.stop_rec_end_loop();
    /////////////////////////////////////////////
  }

  ///////////////////
  //      END      //
  ///////////////////
  // REC  END  //////
  rectrack.rec_end();
  ///////////////////

  //  !!!!!! put end here  !!!!!!

  //// STOP REC ///////////
  rectrack.stop_rec_end(); 
  /////////////////////////
}  
