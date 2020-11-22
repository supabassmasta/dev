Hid hi;
HidMsg msg;

<<< "KEYBOARD SYNC ENABLED: Press 'r' to resync (4 ticks), 't' to adjust tempo (5 times min)">>>;
// which keyboard
0 => int device;
// get from command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// open keyboard (get device number from command line)
if( !hi.openKeyboard( device ) ) me.exit();
<<< "keyboard '" + hi.name() + "' ready", "" >>>;


0::ms => dur d;
now => time tref;
dur da [4];
dur dmean;
0 => int dnb;


// infinite event loop
while( true )
{
    // wait on event
    hi => now;

    // get one or more messages
    while( hi.recv( msg ) )
    {
        // check for action type
        if( msg.isButtonDown() )
        {
            <<< "down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
          if (msg.which == 19) // 'r'
          {
            MASTER_SEQ3.update_ref_times(now, data.tick * 4);
          }

          if (msg.which == 20) {
            now - tref => d;
            now => tref;

            if (data.tick * .6 < d && d < data.tick * 1.4) {
               d => da[dnb]; 
               1+=>dnb;
               if (dnb == 4) {
                 (da[0] + da[1] + da[2] + da[3]) / 4 => dmean;
                 MASTER_SEQ3.update_durations(dmean, 1);
                 0=> dnb;
                 <<<"UPDATE tick", data.tick, " BPM", 60::second / data.tick>>>; 
               }
            }
            else {
               0 => dnb;
               <<<"Invalid Tick to update BPM reset counter">>>; 
            }
          }
        }
        
        else
        {
            //<<< "up:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
        }
    }
}

//



