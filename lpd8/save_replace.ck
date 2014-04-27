if( me.args() == 0) {
    <<<"please set a .ck as input">>>;
    me.exit;   
}

me.arg(0) => string file_name;

Machine.add( file_name) => int shred_id;

fun void kb_management (Hid hi)
    {
        HidMsg msg; 
        int num;
        // infinite event loop
        while( true )
        {
            // wait on event
            hi => now;
        
            // get one or more messages
            while( hi.recv( msg ) )
            {
                //<<<"note_active 1",note_active>>>;
                // check for action type
                if( msg.isButtonDown() )
                {
                     //<<< "down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
                    if(msg.which == 31 ){
                        Machine.remove(shred_id);
                        Machine.add( file_name);
                    
                    }

                }
            }
        }
    }
    
    
    
        //--------------------------------------------//
        //               kb Init                      //
        //--------------------------------------------//
        Hid hi;

        // open keyboard 0
        if( !hi.openKeyboard( 0 ) ) me.exit();
        <<< "keyboard '" + hi.name() + "' ready", "" >>>;

        spork ~ kb_management(hi);

        
while(1) 10::second => now;
