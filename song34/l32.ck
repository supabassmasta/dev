fun void  SEQ  (){ 
  /// PLAY OR REC /////////////////
  RECSEQ recseq; "seqname1.wav"=>recseq.name_main; 0=>recseq.compute_mode; 1=>recseq.rec_mode;8*data.tick=>recseq.main_extra_time;
  if (recseq.play_or_rec() ) {
    //////////////////////////////////

    //////////////////////////////////////////////////
    // MAIN 
    //////////////////////////////////////////////////

    //  !!!!!!  Put main code here  !!!!!
    // Call this with file and fun name to record all seq on fresh cloned project
    // if (! MISC.file_exist( "seqname0.wav") SEQNAME0();


    SinOsc sin0 => PowerADSR padsr => dac;
    padsr.set(1::ms, 20::ms, .7 , 20::ms);
    padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave dac;
    500.0 => sin0.freq;
    .2 => sin0.gain;

    for (0 => int i; i <  5     ; i++) {
      padsr.keyOn();
      <<<"ON">>>;
      200::ms => now;
      padsr.keyOff();
      200::ms => now;
    }
    //// STOP REC ///////////////////////////////
    recseq.rec_stop();
    //////////////////////////////////////////////////
  } 

} 
     if (! MISC.file_exist( "seqname1.wav")) SEQ();


while(1) {
spork ~   SEQ (); 
       2050::ms => now;
}
 

