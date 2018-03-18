		200::ms => dur latency;

// Test
SinOsc s => PowerADSR padsr => dac;
padsr.set(1::ms, 20::ms, .0000000000007 , 20::ms);
padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 

600 => s.freq;
.4 => s.gain;

fun void f1 (){ 
	60000::ms/data.bpm - 202::ms => now;
	while(1) {
		padsr.keyOn();
		60000::ms/data.bpm => now;
	}
 
	 } 


fun void f2 (){ 
	60000::ms/data.bpm - 202::ms => now;
   padsr.keyOn();
	 } 

		"Midi Through Port-0" => string device;
    MidiIn min;
    MidiMsg msg;
		// open the device
		for(0 =>  int i; i < 8; i++ )
		{
				// no print err
		//    min.printerr( 0 );

				// open the device
				if( min.open( i ) )
				{
						if ( min.name() == device ) {
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

		<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

        while( true )
        {
					min => now;

					while( min.recv(msg) )
					{
//						<<< msg.data1, msg.data2, msg.data3 >>>;
						if (msg.data1 == 144 && msg.data2 == 45 /* && msg.data3 == 144 */){
//	            MASTER_SEQ3.update_ref_times(now - latency, data.tick * 4);
	 spork ~ f2 ();
	  

//							<<<"RESYNC">>>;
					}

					}
        }

while(1) {
	     100::ms => now;
}
 
