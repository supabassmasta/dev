public class KBCONTROLLER {


  CONTROLER updown;
  CONTROLER leftright;

  0. => float updown_val;
  0. => float leftright_val;
  
  0 => int ctrl_dn;
  // KB management
  Hid hi;

  // open keyboard 0
  if( !hi.openKeyboard( 0 ) ) me.exit();
  <<< "keyboard '" + hi.name() + "' ready", "" >>>;
  spork ~ kb_management(hi);

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
//         	<<< "KBCONTROLLER down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
          //--------------------------------------------//
          //--------------------------------------------//
          if(msg.which == 29 || msg.which == 97)
          {
            // CTRL
            1 => ctrl_dn;
          }

          else if(msg.which == 103)
          {
            // UP
            if (ctrl_dn) {
              updown_val + 10 => updown_val;
            }
            else {
              updown_val + 1 => updown_val;
            }

//            <<<"KBCONTROLLER up:", updown_val>>>;
            updown.set(updown_val);
          }
          else if(msg.which == 108)
          {
            // DOWN
            if (ctrl_dn) {
              updown_val - 10 => updown_val;
            }
            else {
              updown_val - 1 => updown_val;
            }

//            <<<"KBCONTROLLER down:", updown_val>>>;
            updown.set(updown_val);
          }
          else if(msg.which == 105)
          {
            // LEFT
            if (ctrl_dn) {
              leftright_val - 10 => leftright_val;
            }
            else {
              leftright_val - 1 => leftright_val;
            }

//            <<<"KBCONTROLLER left:", leftright_val>>>;
            leftright.set(leftright_val);
          }
          else if(msg.which == 106)
          {
            // RIGHT
            if (ctrl_dn) {
              leftright_val + 10 => leftright_val;
            }
            else {
              leftright_val + 1 => leftright_val;
            }

//            <<<"KBCONTROLLER right:", leftright_val>>>;
            leftright.set(leftright_val);
          }
        } 
        else if ( msg.isButtonUp() )
        {
//   				<<< "KBCONTROLLER up:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;

          if(msg.which == 29 || msg.which == 97)
          {
            // CTRL
            0 => ctrl_dn;
          }

        }
      }
    }
  }




}



