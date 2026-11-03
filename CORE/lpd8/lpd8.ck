public class lpd8 {
    // device number
    "LPD8 MIDI 1" => string device;
    "Akai LPD8 Wireless MIDI 1" => string device2;

    MidiIn min;
    MidiMsg msg;
    string devname;
//   if( !min.open( device ) ) me.exit();

// <<< "MIDI device:", min.num(), " -> ", min.name() >>>;
    // <<< "MIDI device not open for test!!!" >>>;
for(0 =>  int i; i < 8; i++ )
{
    // no print err
//    min.printerr( 0 );

    // open the device
    if( min.open( i ) )
    {
        min.name() => devname;
        if (devname.find(device) != -1 || devname.find(device2) != -1){ // To skip random numbers at the end of the string on debian
        <<< "device", i, "->", min.name(), "->", "open: SUCCESS" >>>;
				break;
				}
				else {
//					min.close();
				}

   }
    else break;
}

<<< "MIDI device:", min.num(), " -> ", min.name() >>>;


    fun void potar_ext (int group_no, int pad_nb, int val) {}
    fun void pad_ext (int group_no, int pad_nb, int val) {}

    fun void start_midi_rcv() {
    	int group_no_;
    	int pad_nb_;
   	 int val_;

        while( true )
        {
            min => now;

            while( min.recv(msg) )
            {
                <<< msg.data1, msg.data2, msg.data3 >>>;

                msg.data1  => group_no_;
                msg.data2 => pad_nb_;
                msg.data3 => val_;
                
                if (pad_nb_> 8)
                    pad_ext (group_no_, pad_nb_, val_);
                else
                    potar_ext (group_no_, pad_nb_, val_);
                
                
            }
        }
    }
    
    spork ~ start_midi_rcv() ;
    

}
