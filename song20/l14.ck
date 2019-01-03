class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .7 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*1
1!1!1_ ____
" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

class STSYNCBPF extends ST{
  BPF filterl => outl;
  BPF filterr => outr;

  class nirx extends note_info_rx {
    
    BPF @ fl;
    BPF @ fr;

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
        filter_freq.last() => fl.freq => fr.freq;
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
    q => nio.fl.Q => nio.fr.Q;
  }

  fun void adsr_set(float ra, float rd, float sustain, float rs, float rr) {
    ra => nio.rel_attack;
    rd => nio.rel_decay;
    sustain => nio.sustain;
    rs => nio.rel_sustain_dur;
    rr => nio.rel_release;
  }
}

STSYNCBPF stsyncbpf;
stsyncbpf.freq(100 /* Base */, 10 * 100 /* Variable */, 4. /* Q */);
stsyncbpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsyncbpf.connect(t $ ST, t.note_info_tx_o); 

while(1) {
       100::ms => now;
}
 


