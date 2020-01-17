  "Midi Through Port-0" => string device;
MidiOut mout;

  // open the device
  for(0 =>  int i; i < 8; i++ )
  {
    // no print err
    //    mout.printerr( 0 );

    // open the device
    if( mout.open( i ) )
    {
      if ( mout.name() == device ) {

        if(mout.open(i)) {
          <<< "device", i, "->", mout.name(), "->", "open as output: SUCCESS" >>>;
        }
        else {
          <<<"Fail to open launchpad as output">>>; 
        }

        break;
      }
      else {
//        					mout.close();
      }

    }
    else {
      <<<"Cannot open", device>>>; 	
      break;
    }

  }

<<< "MIDI device:", mout.num(), " -> ", mout.name() >>>;


    MidiMsg msg;
    
    148 => msg.data1;
    127 => msg.data2;
    127 => msg.data3;
    mout.send(msg);

<<<"PARALLEL SYNC Message sent, exit script">>>;

    1::ms => now;
    
