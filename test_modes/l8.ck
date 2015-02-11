// number of the device to open (see: chuck --probe)
3 => int device;
// get command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// the midi event
MidiOut min;
// the message for retrieving data
MidiMsg msg;
MidiMsg msg_old;

// open the device
if( !min.open( device ) ) me.exit();

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

// infinite time-loop
0 => int i;
0 => int j;

fun void f1 (){ 

	 } 
	 spork ~ f1 ();
	  
while(1) {
	 144 => msg.data1;			
	j*16 + i => msg.data2 ;			
	 0x30 => msg.data3 ;			
		
	if (i++ >= 7) {j++; 0=> i;}
		if (j>7) {0=> j;}


 min.send(msg);
	 0 => msg_old.data3 ;
 min.send(msg_old);
msg.data1 => msg_old.data1;
msg.data2 => msg_old.data2;
	     100::ms => now;
}
		

/* while( true )
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
*/
