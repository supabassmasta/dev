SEQ s;  //data.tick * 8 => s.max;  // 
SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"s~_ss*4tt~t" => s.seq;
.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 


class STADSR extends ST{
  ADSR adsrl => outl;
  ADSR adsrr => outr;

  adsrl.set(1::ms, 10::ms, .00001, 10::ms);
  adsrr.set(1::ms, 10::ms, .00001, 10::ms);

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
stadsr.connect(s $ ST, s.note_info_tx_o);


while(1) {
       100::ms => now;
}
 
