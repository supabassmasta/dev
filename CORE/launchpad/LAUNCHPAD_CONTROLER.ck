public class LAUNCHPAD {
  "Launchpad S MIDI 1" => string device;
  "Launchpad MK2 MIDI 1" => string device2;

  0 => int MK2;

  MidiIn min;
  MidiMsg msg;
  MidiOut mout;	

  // open the device
  for(0 =>  int i; i < 8; i++ )
  {
    // no print err
    //    min.printerr( 0 );

    // open the device
    if( min.open( i ) )
    {
      if ( min.name() == device || min.name() == device2) {
        if (  min.name() == device2  ){
          1 => MK2; 
        }

        <<< "device", i, "->", min.name(), "->", "open as input: SUCCESS" >>>;

        if(mout.open(i)) {
          <<< "device", i, "->", mout.name(), "->", "open as output: SUCCESS" >>>;
        }
        else {
          <<<"Fail to open launchpad as output">>>; 
        }

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


  CONTROLER  keys[121];
  CONTROLER  controls[112];


  0 => int last_key;
  0 => int last_control;


  fun void start_midi_rcv() {
    int color;
    int nt;
    while( true )
    {
      min => now;

      while( min.recv(msg) )
      {
        <<< msg.data1, msg.data2, msg.data3 >>>;

        if (msg.data1 == 144){
          if ( MK2 ){
            mk2_convert_note_to_S(msg.data2) => nt;
          }
          else {
            msg.data2 => nt;
          }

          keys[nt].set(msg.data3); 
          nt=> last_key;
        }
        else {
          controls[msg.data2].set(msg.data3);
          msg.data2=> last_control;
        }
      }
    }

  }

  fun int mk2_convert_note_to_S(int n) {
    // row and column of mk2
    n / 10  => int row;
    n - (row * 10) => int col;

    // convert to S
    8 - row => int i;
    col - 1 => int j;

    return ( i * 16 + j );
  }

  fun int S_convert_note_to_mk2(int n) {
    // row and column to S
    n / 16 => int row;
    n - (row * 16) => int col;

    // convert to MK2
    8 - row => int i;
    col + 1 => int j;

    return (i * 10 + j);
  }

  fun void reset(){
    MidiMsg msg;

    if ( MK2  ){
      for (10 => int i; i < 90; 10 +=> i) {
        for (1 => int j; j < 10; j++) {
          144 => msg.data1;
          i + j => msg.data2;
          0 => msg.data3;
          mout.send(msg);
        }
      }

      for (104 => int i; i < 112      ; i++) {
        176 => msg.data1;
        i => msg.data2;
        0 => msg.data3;
        mout.send(msg);
      }
    }
    else {
      176 => msg.data1;
      0 => msg.data2;
      0 => msg.data3;
      mout.send(msg);
    }

  }

  fun void set_color(int channel, int note, int color ){
    MidiMsg msg;

    if ( MK2  && channel == 144 ){
      S_convert_note_to_mk2(note) => note;
    }

    channel => msg.data1;
    note => msg.data2;
    color => msg.data3;
    mout.send(msg);
  }
  
  fun void color(int note, int c){
    if ( MK2  )
      set_color(144, note, c);
    else
      set_color(144, note, 2); // Red
  }
  
  fun void red(int note){
    if ( MK2  )
      set_color(144, note, 72);
    else
      set_color(144, note, 2);
  }

  fun void green(int note){
    if ( MK2  )
      set_color(144, note, 17);
    else
      set_color(144, note, 32);
  }

  fun void amber(int note){
    if ( MK2  )
      set_color(144, note, 37);
    else
      set_color(144, note, 34);
  }
 
  fun void clear(int note){
    set_color(144, note, 0);
  }

  fun void colorc(int note, int c){
    if ( MK2  )
      set_color(176, note, c);
    else
      set_color(176, note, 2); // Red
  }

  fun void redc(int note){
    if ( MK2  )
      set_color(176, note, 72);
    else
      set_color(176, note, 2);
  }

  fun void greenc(int note){
    if ( MK2  )
      set_color(176, note, 17);
    else
      set_color(176, note, 32);
  }

  fun void amberc(int note){
    if ( MK2  )
      set_color(176, note, 37);
    else
      set_color(176, note, 34);
  }

  fun void clearc(int note){
    set_color(176, note, 0);
  }


  fun void virtual_key_on(int sid /* script id, example 11 for z11.ck) */) {
    int i, j, note;

    if (sid > 10) {
      // compute note from sid
      sid/10 - 1 => i;
      sid - (i+1)*10 - 1 => j;

      i*16 + j => note;

      // Call controls attached on the key
      keys[note].set(127); 
      // note=> last_key;
    }
    else {
      controls[sid + 103].set(127);
    }

  }

  fun void virtual_key_on_only(int sid /* script id, example 11 for z11.ck) */) {
    int i, j, note;

    if (sid > 10) {
      // compute note from sid
      sid/10 - 1 => i;
      sid - (i+1)*10 - 1 => j;

      i*16 + j => note;

      // Call controls attached on the key
      keys[note].set(126); 
      // note=> last_key;
    }
    else {
      controls[sid + 103].set(126);
    }

  }

  fun void virtual_key_off_only(int sid /* script id, example 11 for z11.ck) */) {
    int i, j, note;

    if (sid > 10) {
      // compute note from sid
      sid/10 - 1 => i;
      sid - (i+1)*10 - 1 => j;

      i*16 + j => note;

      // Call controls attached on the key
      keys[note].set(125); 
      // note=> last_key;
    }
    else {
      controls[sid + 103].set(125);
    }

  }
  fun void virtual_key_off(int sid /* script id, example 11 for z11.ck) */) {
    int i, j, note;


    if (sid > 10) {
      // compute note from sid
      sid/10 - 1 => i;
      sid - (i+1)*10 - 1 => j;

      i*16 + j => note;

      // Call controls attached on the key
      keys[note].set(0); 
      msg.data2=> last_key;
    }
    else {
      controls[sid - 1].set(0);
    }

  }


  fun void start () {	
    spork ~ start_midi_rcv() ;
  }

  fun int file_exist (string filename){ 
    FileIO fio;
    fio.open( filename, FileIO.READ );
    if( !fio.good() )
      return 0;
    else {
      fio.close();
      return 1;
    }
  } 


}
