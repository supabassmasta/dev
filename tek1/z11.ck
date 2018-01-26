0 => int device;

// the midi event
MidiIn min;
// the message for retrieving data
MidiMsg msg;

// open the device
if( !min.open( device ) ) me.exit();

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

time last;

0 => int idx;
dur interv[4];
dur mean;


// infinite time-loop
while( true )
{
    // wait on the event 'min'
    min => now;

    // get the message(s)
    while( min.recv(msg) )
    {
        // print out midi message
        <<< msg.data1, msg.data2, msg.data3 >>>;

				if ( msg.data1 == 144 ) {
						if ( msg.data2 == 72 ) {
							now - last =>  interv[idx%4];
							1+=>idx;
							now => last;
						if (idx > 4) {
										 0::ms => mean;
								for (0 => int i; i < 4      ; i++) {
										 interv[i] +=> mean;
								}
										 mean/4 => mean;
								 

								MASTER_SEQ3.update_tick(now-30::ms, 4 * mean, 4);
							}
						}
						else if ( msg.data2 == 67 ){
								now - last =>  interv[idx%4];
								1+=>idx;
								now => last;

						}
				}
    }
}
