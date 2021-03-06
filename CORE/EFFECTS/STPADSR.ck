  class nirx extends note_info_rx {
    PowerADSR @ al;
    PowerADSR @ ar;
    Gain @ ol;
    Gain @ or;
    10::ms => dur d_to_keyoff;

    0 => int push_nb; // To avoid keyOff overlap
    0 => int connected; // to avoid double connect when release not over

    dur rDur;
    
    fun void off_delayed( int off_nb){
      d_to_keyoff => now;
      
      if (off_nb == push_nb) {
        al.keyOff();
        ar.keyOff();
        //<<<"ADSR OFF">>>;

      }
      //else {
      //  <<<"ADSR off discarded">>>;
      //}
      rDur => now;
      if (off_nb == push_nb) {
        al =< ol;
        ar =< or;
        0 => connected; 
      }

    }

    fun void push(note_info_t @ ni ) {
      // <<<"Note info, idx ", ni.idx, " dur ", ni.d/1::ms, " ms, on ", ni.on>>>;
      if(ni.on) {
        if ( ! connected ){
          al => ol;
          ar => or;
          1 => connected;
        }
        al.keyOn();
        ar.keyOn();
        1 +=> push_nb;
        spork ~ off_delayed(push_nb);
      }


    }
  }

public class STPADSR extends ST{
  PowerADSR adsrl ;
  PowerADSR adsrr ;
  nirx nio;
  adsrl @=> nio.al;
  adsrr @=> nio.ar;

  outl @=> nio.ol;
  outr @=> nio.or;

  dur dur_to_keyoff;
  dur rel;


  adsrl.set(1::ms, 10::ms, .00001, 10::ms);
  adsrr.set(1::ms, 10::ms, .00001, 10::ms);

  adsrl.setCurves(2.0, 2.0, .5);
  adsrr.setCurves(2.0, 2.0, .5);
  
  fun void set(dur a, dur d, float s, dur sd, dur r){
    adsrl.set(a, d, s, r);
    adsrr.set(a, d, s, r);
    a + d + sd => dur_to_keyoff => nio.d_to_keyoff;
    r => nio.rDur;
    r => rel;
  }
  
  fun void setCurves(float a, float d, float r) {
    adsrl.setCurves( a, d, r);
    adsrr.setCurves( a, d, r);
  }

  fun void connect(ST @ tone, note_info_tx @ ni_tx) {

    tone.left() => adsrl;
    tone.right() => adsrr;

    // Register note info rx in tx
    ni_tx.reg(nio);
  }


  // MANUAL noteOn Off
  0 => int push_nb; // To avoid keyOff overlap
  0 => int connected; // to avoid double connect when release not over

  fun void connect(ST @ tone) {

    tone.left() => adsrl;
    tone.right() => adsrr;
  }

  fun void keyOn(){
    if ( ! connected ){
      adsrl => outl;
      adsrr => outr;
      1 => connected;
    }
    adsrl.keyOn();
    adsrr.keyOn();
    1 +=> push_nb;
  }
  
  fun void off_delayed( int off_nb){
    rel => now;
    if (off_nb == push_nb) {
      adsrl =< outl;
      adsrr =< outr;
      0 => connected; 
    }
  }

  fun void keyOff(){
    adsrl.keyOff();
    adsrr.keyOff();
    spork ~ off_delayed(push_nb);
  }
}
