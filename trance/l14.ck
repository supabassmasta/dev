// number of the device to open (see: chuck --probe)
0 => int device;
// get command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// the midi event
MidiIn min;
// the message for retrieving data
MidiMsg msg;

// open the device
if( !min.open( device ) ) me.exit();

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

// infinite time-loop
while( true )
{
    // wait on the event 'min'
    min => now;

    // get the message(s)
    while( min.recv(msg) )
    {
        // print out midi message
//        <<< msg.data1, msg.data2, msg.data3 >>>;
        if (msg.data1 ==144 && msg.data2 == 48 && msg.data3 == 64 ) {
            <<<"SYNC">>>; 
            MASTER_SEQ3.update_ref_times(now, data.tick * 16);
        }
    }
}
