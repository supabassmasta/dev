class nirx extends note_info_rx {
  ADSR @ pa;

  fun void push(note_info_t @ ni ) {
    <<<"Note info, idx ", ni.idx, " dur ", ni.d/1::ms, " ms, on ", ni.on>>>;
    if(ni.on) {
      pa.keyOn();
    }
    else {
      pa.keyOff();   
    }
  }
}


public class STTREMOLO extends ST{

  Step step => Gain add => Gain treml =>outl;
  add => Gain tremr =>outr;

  3 => treml.op => tremr.op;
  1. => step.next ;

  SinOsc mod => ADSR pa => add;
  .2 => mod.gain;
  5 => mod.freq;

  pa.set(data.tick *2 , 0::ms , 1., 700::ms);

  nirx nio;
  pa @=> nio.pa;

  fun void connect(ST @ tone, note_info_tx @ ni_tx) {

    tone.left() =>  treml;
    tone.right() => tremr;

    // Register note info rx in tx
    ni_tx.reg(nio);
  }

}

class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

