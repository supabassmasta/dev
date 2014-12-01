
    // RYTHM
//    rythm rythm_o;
    
    // init rythm
//     rythm_o.constructor();
     //rythm_o.tick_delay

     // REC duration
//      rythm_o.tick_nb * rythm_o.tick_delay * 4 => dur rec_dur;

	0 => int flag_rec;
      

    //--------------------------------------------//
    //               kb Init                      //
    //--------------------------------------------//
    Hid hi;
    HidMsg msg; 

    // open keyboard 0
    if( !hi.openKeyboard( 0 ) ) me.exit();
    <<< "keyboard '" + hi.name() + "' ready", "" >>>;
 
fun void fun_rec() {
    3::ms => dur anticrousti;
    1 => flag_rec;

    dac.right => ADSR ar =>  WvOut wr => blackhole;
    ar.set (anticrousti, 0::ms, 1, anticrousti);
    "chuck-session-RIGHT" => wr.autoPrefix;
    "special:auto" => wr.wavFilename;

    dac.left => ADSR al =>  WvOut wl => blackhole;
    al.set (anticrousti, 0::ms, 1, anticrousti);
    "chuck-session-LEFT" => wl.autoPrefix;
    "special:auto" => wl.wavFilename;
    
    ar.keyOn();
    al.keyOn();

    while (flag_rec) 1::ms => now;	
     }


     
    while( true )
    {
            // wait on event
        hi => now;
    
        // get one or more messages
        while( hi.recv( msg ) )
        {

            if( msg.isButtonDown() ) {
            // <<< "down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
                if (msg.which == 57) {
		   if (flag_rec == 0) {
                    <<<"REC">>>;
                    spork ~ fun_rec();
		   }
                   else {
                       0 => flag_rec;
                    <<<"REC STOP">>>;
                   }
  
     
                }
            }
        }
        
        
    }
