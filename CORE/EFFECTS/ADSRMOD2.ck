class nirx extends note_info_rx {
  PowerADSR @ pa;  
  float rel_attack;
  float rel_decay;
  float sustain;
  float rel_release;
  float rel_release_pos;
  0 => int off_cnt;

  fun void off(int nb, dur att_dec_sus) {
    att_dec_sus => now;
    if (nb == off_cnt) {
      pa.keyOff();
//            <<<"OFF: ", nb>>>;
    }
    // else skip, new note already ongoing
    //    else {
    //      <<<"OFF skipped: ", nb, "off_cnt :", off_cnt>>>;
    //    }
  }

  fun void push(note_info_t @ ni ) {
    if(ni.on) {
      pa.set(rel_attack * ni.d , rel_decay * ni.d , sustain, rel_release * ni.d);
      pa.keyOn();

      1 +=> off_cnt;
      spork ~ off( off_cnt,  ni.d + (rel_release_pos*ni.d) );
    }
  }

}


public class ADSRMOD2 {

  Step stp => Gain out;
  Gain in => PowerADSR padsr => out;
  1. => stp.next;

  nirx nio;
  padsr @=> nio.pa;
  fun void connect(SYNT @ synt, note_info_tx @ ni_tx) {

    3 => synt.inlet.op;
    out => synt.inlet;

    // Register note info rx in tx
    ni_tx.reg(nio);

  }

  fun void adsr_set(float ra, float rd, float sustain, float rr_pos, float rr) {
    ra => nio.rel_attack;
    rd => nio.rel_decay;
    sustain => nio.sustain;
    rr_pos => nio.rel_release_pos;
    rr => nio.rel_release;
  }

}

