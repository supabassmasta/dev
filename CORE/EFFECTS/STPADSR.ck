  class nirx extends note_info_rx {
    PowerADSR @ al;
    PowerADSR @ ar;
    10::ms => dur d_to_keyoff;

    0 => int push_nb; // To avoid keyOff overlap
    
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
    }

    fun void push(note_info_t @ ni ) {
      // <<<"Note info, idx ", ni.idx, " dur ", ni.d/1::ms, " ms, on ", ni.on>>>;
      if(ni.on) {
        al.keyOn();
        ar.keyOn();
        1 +=> push_nb;
        spork ~ off_delayed(push_nb);
      }


    }
  }

public class STPADSR extends ST{
  PowerADSR adsrl => outl;
  PowerADSR adsrr => outr;
  dur dur_to_keyoff;


  adsrl.set(1::ms, 10::ms, .00001, 10::ms);
  adsrr.set(1::ms, 10::ms, .00001, 10::ms);

  adsrl.setCurves(2.0, 2.0, .5);
  adsrr.setCurves(2.0, 2.0, .5);

  nirx nio;
  adsrl @=> nio.al;
  adsrr @=> nio.ar;
  
  fun void set(dur a, dur d, float s, dur sd, dur r){
    adsrl.set(a, d, s, r);
    adsrr.set(a, d, s, r);
    a + d + sd => dur_to_keyoff => nio.d_to_keyoff;
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

  fun void connect(ST @ tone) {

    tone.left() => adsrl;
    tone.right() => adsrr;
  }

  fun void keyOn(){
      adsrl.keyOn();
      adsrr.keyOn();
  }
  fun void keyOff(){
      adsrl.keyOff();
      adsrr.keyOff();
  }
}
