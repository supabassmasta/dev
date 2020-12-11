  "Midi Through Port-0" => string device;
MidiOut mout;

  // open the device
  for(0 =>  int i; i < 8; i++ )
  {
    // no print err
    //    mout.printerr( 0 );

    // open the device
    if( mout.open( i ) )
    {
      if ( mout.name() == device ) {

        if(mout.open(i)) {
          <<< "device", i, "->", mout.name(), "->", "open as output: SUCCESS" >>>;
        }
        else {
          <<<"Fail to open launchpad as output">>>; 
        }

        break;
      }
      else {
//        					mout.close();
      }

    }
    else {
      <<<"Cannot open", device>>>; 	
      break;
    }

  }

<<< "MIDI device:", mout.num(), " -> ", mout.name() >>>;

////////////////////////////////////////////

Step f => PLOC0 p =>dac;

Std.mtof(60 + 7) => f.next;
.7 => p.gain;

////////////////////////////////////////////



MidiMsg msg;

    // Song Position pointer : Begining
    242 => msg.data1;
    0 => msg.data2;
    0 => msg.data3;
    mout.send(msg);

    // Start
    250 => msg.data1;
    0 => msg.data2;
    0 => msg.data3;
    mout.send(msg);

0 => int midi_cnt;


SinOsc sin0 =>  OFFSET ofs0 => blackhole;
130. => ofs0.offset;
1. => ofs0.gain;

0.01 => sin0.freq;
40.0 => sin0.gain;

10::ms => now;
fun void f1 (){ 
  while(1) {
    ofs0.last() => float bpm;
//    <<<"bpm", bpm>>>;
    bpm => data.bpm;
    60::second / bpm => data.tick; 
    100::ms => now;
  }
} 
//spork ~ f1 ();



while(1) {
    if ( ! ( midi_cnt % (24 ) ) ){
      if ( ! ( midi_cnt % (24 * 4 ) ) ){
        Std.mtof(60 + 7) => f.next;
//        <<<"data.tick", data.tick>>>;
 <<<"BPM:", data.bpm >>>;

      }
      else {
        Std.mtof(60 + 0) => f.next;
      }
      p.new_note(0); 
    }
    
    // Midi Clock
    248 => msg.data1;
    0 => msg.data2;
    0 => msg.data3;
    mout.send(msg);

    1 +=> midi_cnt;

    data.tick / ( 24 )   => now;

//    (LPD8.pot[0][0] + 50) => int bpm;

//    <<<"BPM:", bpm >>>;

//    60::second / bpm => data.tick;


}

