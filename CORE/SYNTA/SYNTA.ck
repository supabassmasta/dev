public class SYNTA extends ST {
	fun void in(	MidiMsg msg){}
	
  note_info_tx note_info_tx_o;
  note_info_t ni;
  1000::ms => ni.d;
  0 => ni.idx;

  // TO INCLUDE IN in() function when creating a new SYNTA
  fun void  send_note_info(MidiMsg msg){
  	if (msg.data1 == 144){
      1 => ni.on;
	  }
		else if (msg.data1 == 128){
      0 => ni.on;
    }
    
    note_info_tx_o.push_to_all(ni);
}

}

