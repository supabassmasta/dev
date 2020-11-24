  "Midi Through Port-0" => string device;

// the midi event
MidiIn min;
// the message for retrieving data
MidiMsg msg;

  // open the device
  for(0 =>  int i; i < 8; i++ )
  {
    // no print err
    //    min.printerr( 0 );

    // open the device
    if( min.open( i ) )
    {
      if ( min.name() == device )  {

        <<< "device", i, "->", min.name(), "->", "open as input: SUCCESS" >>>;

        break;
      }
      else {
        //					min.close();
      }

    }
    else {
      <<<"Cannot open", device>>>; 	
      break;
    }

  }

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

0 => int synced;

// infinite time-loop
while( synced == 0 )
{
    // wait on the event 'min'
    min => now;

    // get the message(s)
    while( min.recv(msg) )
    {
        // print out midi message
        <<< msg.data1, msg.data2, msg.data3 >>>;

        if (  msg.data1 == 148 && msg.data2 == 127 && msg.data3 == 127 ){
             MASTER_SEQ3.update_ref_times(now, data.tick * 4);

             1 => synced;
             <<<"PARALLEL SYNC message received, SYNCED, exit script">>>;

        }
    }
}

1::ms => now;


fazefazef NOT COMPILE
