class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c
1_3_ 5_8
" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

class STADSR extends ST{
  ADSR adsrl => outl;
  ADSR adsrr => outr;

  adsrl.set(1::ms, 20::ms, .00001, 10::ms);
  adsrr.set(1::ms, 20::ms, .00001, 10::ms);

  class nirx extends note_info_rx {
    ADSR @ al;
    ADSR @ ar;
    fun void push(note_info_t @ ni ) {
       <<<"Note info, idx ", ni.idx, " dur ", ni.d/1::ms, " ms, on ", ni.on>>>;
      if(ni.on) {
        al.keyOn();
        ar.keyOn();
      }


    }
  }

  nirx nio;
  adsrl @=> nio.al;
  adsrr @=> nio.ar;
  
  

  fun void connect(ST @ tone, note_info_tx @ ni_tx) {

    tone.left() => adsrl;
    tone.right() => adsrr;

    // Register note info rx in tx
    ni_tx.reg(nio);
  }

}

STADSR stadsr;
stadsr.connect(t $ ST, t.note_info_tx_o);


while(1) {
       100::ms => now;
}
 
