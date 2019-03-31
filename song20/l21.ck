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


class STTREMOLO extends ST{

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

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c :4 1_" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(200::ms, 10::ms, 1., 700::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STTREMOLO sttrem;
.5 => sttrem.mod.gain;  5 => sttrem.mod.freq;
sttrem.pa.set(data.tick *6 , 0::ms , 1., 1700::ms);
sttrem.connect(last $ ST, t.note_info_tx_o);  sttrem  $ ST @=>  last; 

//STREV2 rev; // DUCKED
//rev.connect(last $ ST, .3 /* mix */);      rev $ ST @=>  last; 
while(1) {
       100::ms => now;
}
 
