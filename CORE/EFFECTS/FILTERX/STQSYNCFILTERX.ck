class nirx extends note_info_rx {
    
    FILTERX_PATH @ fp;
    1::ms => dur period;
    float rel_attack;
    float rel_decay;
    float rel_release;
    float sustain;
    float rel_sustain_dur;
    0 => int off_cnt;

    float q_rel_attack;
    float q_rel_decay;
    float q_rel_release;
    float q_sustain;
    float q_rel_sustain_dur;

    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    Step q_base => Gain filter_q => blackhole;
    Step q_variable => PowerADSR q_padsr => filter_q;

    // Params
    padsr.set(data.tick / 4 , data.tick / 4 , .0000001, data.tick / 4);
    padsr.setCurves(2.0, 2.0, 1.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

    q_padsr.set(0::ms , data.tick / 4 , 1., data.tick / 4);
    q_padsr.setCurves(1.0, 1.0, 1.); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

    // ADSR Trigger
    //padsr.keyOn(); padsr.keyOff();

    // fun void auto_off(){
    //     data.tick / 4 => now;
    //     padsr.keyOff();
    // }
    // spork ~ auto_off();

    fun void filter_freq_control (){ 
      while(1) {
        filter_freq.last() => fp.freq;
        filter_q.last() => fp.Q;
        period => now;
      }
    } 

    fun void start_freq_control() {
      spork ~ filter_freq_control ();
    }

  fun void off(int nb, dur att_dec_sus) {
    att_dec_sus => now;
    if (nb == off_cnt) {
      padsr.keyOff();
      q_padsr.keyOff();
//      <<<"OFF: ", nb>>>;

    }
    // else skip, new note already ongoing
//    else {
//      <<<"OFF skipped: ", nb, "off_cnt :", off_cnt>>>;
//    }
  }

    fun void push(note_info_t @ ni ) {
      //<<<"Note info, idx ", ni.idx, " dur ", ni.d/1::ms, " ms, on ", ni.on>>>;
      if(ni.on) {
        padsr.set(rel_attack * ni.d , rel_decay * ni.d , sustain, rel_release * ni.d);
        padsr.keyOn();
        q_padsr.set(q_rel_attack * ni.d , q_rel_decay * ni.d , q_sustain, q_rel_release * ni.d);
        q_padsr.keyOn();
        1 +=> off_cnt;
        spork ~ off( off_cnt, ( rel_attack  + rel_decay + rel_sustain_dur) * ni.d);
      }
    }
  }

public class STQSYNCFILTERX extends ST{
  FILTERX_PATH fpath;
  
  // Enable Filter LIMITS
  1 => fpath.enable_limit;
  
  nirx nio;
  fpath @=> nio.fp;

  fun void connect(ST @ tone, FILTERX_FACTORY @ factory, note_info_tx @ ni_tx, int order, int channels, dur period) {
    fpath.build(channels,  order, factory);
    fpath.freq(200);
//    fpath.Q(1);

     if ( channels == 1  ){
         tone.left() => fpath.in[0];
         tone.right() => Gain trash;
         fpath.out[0] => outl;
         fpath.out[0] => outr;
     }
     else if (channels > 1) {
        tone.left() => fpath.in[0];
        tone.right() => fpath.in[1];
 
        fpath.out[0] => outl;
        fpath.out[1] => outr;
     }
    // Register note info rx in tx
    ni_tx.reg(nio);
    period => nio.period;
    nio.start_freq_control();
  }

  fun void freq(float base, float variable){
    base => nio.base.next;
    variable => nio.variable.next;
  }

  fun void q(float base, float variable){
    base => nio.q_base.next;
    variable => nio.q_variable.next;
  }

  fun void adsr_set(float ra, float rd, float sustain, float rs, float rr) {
    ra => nio.rel_attack;
    rd => nio.rel_decay;
    sustain => nio.sustain;
    rs => nio.rel_sustain_dur;
    rr => nio.rel_release;
  }

  fun void q_adsr_set(float ra, float rd, float sustain, float rs, float rr) {
    ra => nio.q_rel_attack;
    rd => nio.q_rel_decay;
    sustain => nio.q_sustain;
    rs => nio.q_rel_sustain_dur;
    rr => nio.q_rel_release;
  }
}

