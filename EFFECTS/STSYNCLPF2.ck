public class STSYNCLPF2 extends ST{
  LPF filterl => LPF filterl2 => outl;
  LPF filterr => LPF filterr2 => outr;

  class nirx extends note_info_rx {
    
    LPF @ fl;
    LPF @ fr;
    LPF @ fl2;
    LPF @ fr2;

    float rel_attack;
    float rel_decay;
    float rel_release;
    float sustain;
    float rel_sustain_dur;
    0 => int off_cnt;

    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(data.tick / 4 , data.tick / 4 , .0000001, data.tick / 4);
    padsr.setCurves(2.0, 2.0, .5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

    // ADSR Trigger
    //padsr.keyOn(); padsr.keyOff();

    // fun void auto_off(){
    //     data.tick / 4 => now;
    //     padsr.keyOff();
    // }
    // spork ~ auto_off();

    fun void filter_freq_control (){ 
      while(1) {
        filter_freq.last() => fl.freq => fr.freq=> fl2.freq => fr2.freq;
        1::ms => now;
      }
    } 

    fun void start_freq_control() {
      spork ~ filter_freq_control ();
    }

  fun void off(int nb, dur att_dec_sus) {
    att_dec_sus => now;
    if (nb == off_cnt) {
      padsr.keyOff();
//      <<<"OFF: ", nb>>>;

    }
    // else skip, new note already ongoing
//    else {
//      <<<"OFF skipped: ", nb, "off_cnt :", off_cnt>>>;
//    }
  }

    fun void push(note_info_t @ ni ) {
//      <<<"Note info, idx ", ni.idx, " dur ", ni.d/1::ms, " ms, on ", ni.on>>>;
      if(ni.on) {
        padsr.set(rel_attack * ni.d , rel_decay * ni.d , sustain, rel_release * ni.d);
        padsr.keyOn();
        1 +=> off_cnt;
        spork ~ off( off_cnt, ( rel_attack  + rel_decay + rel_sustain_dur) * ni.d);
      }
    }
  }

  nirx nio;
  filterl @=> nio.fl;
  filterr @=> nio.fr;
  filterl2 @=> nio.fl2;
  filterr2 @=> nio.fr2;
  
  fun void connect(ST @ tone, note_info_tx @ ni_tx) {

    tone.left() => filterl;
    tone.right() => filterr;

    // Register note info rx in tx
    ni_tx.reg(nio);
    nio.start_freq_control();
  }

  fun void freq(float base, float variable, float q){
    base => nio.base.next;
    variable => nio.variable.next;
    q => nio.fl.Q => nio.fr.Q => nio.fl2.Q => nio.fr2.Q;
  }

  fun void adsr_set(float ra, float rd, float sustain, float rs, float rr) {
    ra => nio.rel_attack;
    rd => nio.rel_decay;
    sustain => nio.sustain;
    rs => nio.rel_sustain_dur;
    rr => nio.rel_release;
  }
}
