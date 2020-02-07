MidiOut mout;
mout.open(0);

0 => int i;

fun void f1 (){ 

  while(true)
  {
    MidiMsg msg;

    0x90 => msg.data1;
    62 => msg.data2;
    i => msg.data3;
    mout.send(msg);
    1+=> i;
    if ( i >127  ){ 
      0=> i;
    }
    3::samp => now;
//    1::ms => now;

  }
} 
spork ~ f1 ();

0 => int device;
// the midi event
MidiIn min;
// the message for retrieving data
MidiMsg msg;

// open the device
if( !min.open( device ) ) me.exit();

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

fun void f2 (){ 

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

} 
spork ~ f2 ();


while(1) {
       100::ms => now;
}
 
