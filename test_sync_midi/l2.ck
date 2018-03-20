/*
"Scarlett 2i4 USB MIDI 1" => string device;

MidiOut mout;
// open the device
for(0 =>  int i; i < 8; i++ )
{
		// open the device
		if( mout.open( i ) )
		{
				if ( mout.name() == device ) {
				<<< "device", i, "->", mout.name(), "->", "open as output: SUCCESS" >>>;


				break;
				}
				else {
//					mout.close();
				}

	 }
		else {
				<<<"Cannot open", device>>>; 	
			break;
		}
}
*/
  MidiOut  mout;
  mout.open(2);
<<< "MIDI device:", mout.num(), " -> ", mout.name() >>>;


SinOsc s => PowerADSR padsr => dac;
padsr.set(1::ms, 20::ms, .0000000000007 , 20::ms);
padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 

600 => s.freq;
.4 => s.gain;

60000::ms / 110 => dur tick;

while(true)
{
	MidiMsg msg;

	0x90 => msg.data1;
	64 => msg.data2;
	0x7F => msg.data3;

	800 => s.freq;
	padsr.keyOn(); 

	mout.send(msg);
	tick => now;

	0x90 => msg.data1;
	65 => msg.data2;
	0x7F => msg.data3;

	600 => s.freq;
	padsr.keyOn();

	mout.send(msg);
tick => now;

	600 => s.freq;
	padsr.keyOn();

	mout.send(msg);
	tick => now;

	600 => s.freq;
	padsr.keyOn();

	mout.send(msg);
	tick - Std.rand2(-1, 1) * 1::ms => now;
}
