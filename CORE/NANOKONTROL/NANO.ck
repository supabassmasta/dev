public class NANO {

  // NanoKontrol device name
  "nanoKONTROL MIDI 1" => string device;

  MidiIn min;
  MidiMsg msg;

  for(0 =>  int i; i < 8; i++ )
  {
    // no print err
    //    min.printerr( 0 );

    // open the device
    if( min.open( i ) )
    {
      if ( min.name() == device ) {
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

  fun void button_up_ext (int bank, int group, int val) {<<<"button up ", bank, group," : ",val>>>;}
  fun void button_down_ext (int bank, int group, int val) {<<<"button down ", bank, group," : ",val>>>;}

  fun void button_back_ext (int val) {<<<"button back: ",val>>>;}
  fun void button_play_ext (int val) {<<<"button play: ",val>>>;}
  fun void button_forward_ext (int val) {<<<"button forward: ",val>>>;}
  fun void button_loop_ext (int val) {<<<"button loop: ",val>>>;}
  fun void button_stop_ext (int val) {<<<"button stop: ",val>>>;}
  fun void button_rec_ext (int val) {<<<"button rec: ",val>>>;}

  fun void fader_ext (int bank, int group, int val) {<<<"fader: ", bank, group, val>>>;}
  fun void potar_ext (int bank, int group, int val) {<<<"potar: ", bank, group, val>>>;}

  fun void start_midi_rcv() {
    int bank_no;
    int group_no;

    while( true )
    {
      min => now;

      while( min.recv(msg) )
      {
        <<< msg.data1, msg.data2, msg.data3 >>>;

        msg.data1 - 175 => group_no;
        //				<<<"group_no",group_no>>>;

        if ( msg.data2<4) 1=> bank_no;
        else if ( msg.data2<8) 2=> bank_no;
        else if ( msg.data2<12) 3=> bank_no;
        else 4=> bank_no;

        // BUTTON BACK
        if (group_no== 1 && msg.data2 == 47) {
          button_back_ext (msg.data3); 
        }
        // BUTTON play
        else if (group_no== 1 && msg.data2 == 45) {
          button_play_ext (msg.data3); 
        }
        // BUTTON forward
        else if (group_no== 1 && msg.data2 == 48) {
          button_forward_ext (msg.data3); 
        }
        // BUTTON loop
        else if (group_no== 1 && msg.data2 == 49) {
          button_loop_ext (msg.data3); 
        }
        // BUTTON stop
        else if (group_no== 1 && msg.data2 == 46) {
          button_stop_ext (msg.data3); 
        }
        // BUTTON rec
        else if (group_no== 1 && msg.data2 == 44) {
          button_rec_ext (msg.data3);
        }
        // BUTTON UP
        else if (msg.data2%4 == 1) {
          button_up_ext (bank_no,group_no, msg.data3); 
        }
        // BUTTON DOWN
        else if ((msg.data2%4) == 0) {
          button_down_ext (bank_no, group_no, msg.data3); 
        }
        // POTAR
        else if (msg.data2%4 == 3 ) {
          potar_ext (bank_no, group_no, msg.data3);
        }
        // FADER
        else if (msg.data2%4 == 2) {
          fader_ext (bank_no, group_no, msg.data3);
        }
      }
    }
  }


  fun void start () {	
    spork ~ start_midi_rcv();
  }

  start();
}
