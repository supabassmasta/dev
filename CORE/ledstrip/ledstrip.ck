  class tx extends ACTION {
    int byte;
    0 => int opened;
    SerialIO @ serial;
    fun int on_time() {
//      <<<"SERIAL">>>;

      if ( opened) {
//        <<<"serial send bytes">>>; 
        serial.writeByte(byte);
      }
      else {
//        <<<"Warning cannot execute action, serial not openned">>>;
      }
    }

  }

public class LEDSTRIP {

  0 => int opened;
  SerialIO cereal;

  fun void open() {
    SerialIO.list() @=> string list[];

    for(int i; i < list.cap(); i++)
    {
      chout <= i <= ": " <= list[i] <= IO.newline();
    }

    0 => int device;

    cereal.open(device, SerialIO.B115200, SerialIO.BINARY) => opened;
    if (  opened  ){
      <<<"LED SERIAL OPENED">>>;
    }
    else {
      <<<"WARNING LED SERIAL NOT OPENED">>>;
    }

  }

  fun ACTION set_tx(int b) {
    new tx @=> tx @ act;
    b => act.byte;
    opened => act.opened;
    cereal @=> act.serial;
    "serial tx msg : " + b =>  act.name; 
     
    return act;
  }

  fun void _load_preset(int byte) {
      2000::ms => now;
      if ( opened) {
        cereal.writeByte(byte);
        <<<"LED STRIP LOAD PRESET: ", byte>>>;

      }
  }

//  fun void load_preset(int byte) {
//    spork ~ _load_preset(byte);  
//  }

}

