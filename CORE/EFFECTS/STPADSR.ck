  class nirx extends note_info_rx {
    PowerADSR @ al;
    PowerADSR @ ar;
    Gain @ ol;
    Gain @ or;
    10::ms => dur d_to_keyoff;

    0 => int push_nb; // To avoid keyOff overlap
    0 => int connected; // to avoid double connect when release not over

    dur rDur;

    0 => int relative_release_mode;
    0 => float rel_release_pos;
    0 => int disconnect_mode_off; // Avoid stop processing long wav for example
    
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
      if (off_nb == push_nb && ! disconnect_mode_off) {
        al =< ol;
        ar =< or;
        0 => connected; 
      }

    }
    fun void off_delayed( int off_nb, dur att_dec_sus){
      att_dec_sus => now;

      if (off_nb == push_nb) {
        al.keyOff();
        ar.keyOff();
        //<<<"ADSR OFF">>>;
      }
      //else {
      //  <<<"ADSR off discarded">>>;
      //}

      rDur => now;
      if (off_nb == push_nb && ! disconnect_mode_off) {
        al =< ol;
        ar =< or;
        0 => connected; 
      }
    }
    
    fun void push(note_info_t @ ni ) {
      // <<<"Note info, idx ", ni.idx, " dur ", ni.d/1::ms, " ms, on ", ni.on>>>;
      if(ni.on) {
        if ( ! connected && ! disconnect_mode_off ){
          al => ol;
          ar => or;
          1 => connected;
        }
        al.keyOn();
        ar.keyOn();
        1 +=> push_nb;
        if ( relative_release_mode  ){
          spork ~ off_delayed(push_nb,  ni.d + (rel_release_pos*ni.d) );
        } else {
          spork ~ off_delayed(push_nb);
        }
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

  0 => int disconnect_mode_off; // Avoid stop processing long wav for example

  dur dur_to_keyoff;
  dur rel;


  adsrl.set(1::ms, 10::ms, .00001, 10::ms);
  adsrr.set(1::ms, 10::ms, .00001, 10::ms);

  adsrl.setCurves(2.0, 2.0, .5);
  adsrr.setCurves(2.0, 2.0, .5);
  
  fun void set(dur a, dur d, float s, dur sd, dur r){
    0 => nio.relative_release_mode;

    adsrl.set(a, d, s, r);
    adsrr.set(a, d, s, r);
    a + d + sd => dur_to_keyoff => nio.d_to_keyoff;
    r => nio.rDur;
    r => rel;
  }

  fun void set(dur a, dur d, float s, float relative_r_pos, dur r){
    1 => nio.relative_release_mode;

    adsrl.set(a, d, s, r);
    adsrr.set(a, d, s, r);
    r => nio.rDur;
    r => rel;

    relative_r_pos => nio.rel_release_pos;
  }
  
  fun void setCurves(float a, float d, float r) {
    adsrl.setCurves( a, d, r);
    adsrr.setCurves( a, d, r);
  }

  fun void connect(ST @ tone, note_info_tx @ ni_tx) {

    tone.left() => adsrl;
    tone.right() => adsrr;



    if ( disconnect_mode_off  ){
       adsrl => outl;  
       adsrr => outr;
       1 => nio.disconnect_mode_off;
    }

    // Register note info rx in tx
    ni_tx.reg(nio);
  }



  // MANUAL noteOn Off
  0 => int push_nb; // To avoid keyOff overlap
  0 => int connected; // to avoid double connect when release not over

  fun void connect(ST @ tone) {
    if ( disconnect_mode_off  ){
       adsrl => outl;  
       adsrr => outr;
    }

    tone.left() => adsrl;
    tone.right() => adsrr;
  }

  fun void keyOn(){
    if ( ! connected && ! disconnect_mode_off ){
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
    if (off_nb == push_nb && ! disconnect_mode_off) {
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
