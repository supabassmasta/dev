// number of the device to open (see: chuck --probe)
0 => int device;
// get command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// the midi event
MidiIn min;
MidiOut mout;	
// the message for retrieving data
MidiMsg msg;

// open the device
if( !min.open( device ) ) me.exit();
if( !mout.open( device ) ) me.exit();

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

<<<"RESET">>>;
			176 => msg.data1;
			0 => msg.data2;
			0 => msg.data3;
			mout.send(msg);

for (0 => int i; i <  1     ; i++) {
	for (0 => int j; j < 9      ; j++) {
	  (i)*16 + j  => int nt; 

    amber(nt);
}
}

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
    }
}


fun void set_color(int channel, int note, int color ){
			MidiMsg msg;

			channel => msg.data1;
		  note => msg.data2;
			color => msg.data3;
			mout.send(msg);
		}

		fun void red(int note){
				set_color(144, note, 2);
		}

		fun void green(int note){
				set_color(144, note, 32);
		}

		fun void amber(int note){
				set_color(144, note, 34);
		}

