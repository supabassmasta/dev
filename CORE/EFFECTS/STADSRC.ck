  class control_a extends CONTROL {
    ADSR @ alp;
    ADSR @ arp;
    int state;
    int tog;
    int def_on;

    0 => update_on_reg ;

    fun void set (float in) {
      <<<"STADSRC in ", in>>>;

      if ( tog  ){
        if (in != 0.){
          if ( state  ){
            alp.keyOff();
            arp.keyOff();
            0 => state;
          }
          else {
            alp.keyOn();
            arp.keyOn();
            1 => state;
          }
        }
      }
      else { // NO TOG
        if (!def_on){
          if ( in != 0. ){
            alp.keyOn();
            arp.keyOn();
            1 => state;
          }
          else {
            alp.keyOff();
            arp.keyOff();
            0 => state;
          }
        }
        else {
          if ( in == 0. ){
            alp.keyOn();
            arp.keyOn();
            1 => state;
          }
          else {
            alp.keyOff();
            arp.keyOff();
            0 => state;
          }

        }

      }

      if ( state  ){
          <<<"STADSRC ON">>>;
      }
      else {
          <<<"STADSRC OFF">>>;
      }
    }
  }

public class STADSRC extends ST{
  ADSR al => outl;
  ADSR ar => outr;

  control_a ca;
  al @=> ca.alp;
  ar @=> ca.arp;

  fun void connect(ST @ tone, CONTROLER cont, dur attack, dur release, int default_on, int toggle) {
    default_on => ca.def_on;
    toggle =>  ca.tog;

    tone.left() => al;
    tone.right() => ar;
    al.set(attack, 0::ms, 1., release);
    ar.set(attack, 0::ms, 1., release);

    cont.reg(ca);

    if (default_on) {
      al.keyOn();
      ar.keyOn();
      1 => ca.state;
    }
    else {
      al.keyOff();
      ar.keyOff();
      0 => ca.state;
    }
  }


}
