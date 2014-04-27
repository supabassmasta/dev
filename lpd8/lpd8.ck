public class lpd8 {
    // device number
    1 => int device;

    MidiIn min;
    MidiMsg msg;

   if( !min.open( device ) ) me.exit();

 <<< "MIDI device:", min.num(), " -> ", min.name() >>>;
    // <<< "MIDI device not open for test!!!" >>>;


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
                //<<< msg.data1, msg.data2, msg.data3 >>>;

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
