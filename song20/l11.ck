SEQ s;  //data.tick * 8 => s.max;  // 
<<<<<<< HEAD
SET_WAV.TRANCE(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"k" => s.seq;
=======
SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"s~_ss*4tt~t" => s.seq;
>>>>>>> 9aaa7c6e4df36f7a1700bc52f4b3f205f86aeb65
.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 


class STPADSR extends ST{
  PowerADSR adsrl => outl;
  PowerADSR adsrr => outr;
  dur dur_to_keyoff;


  adsrl.set(1::ms, 10::ms, .00001, 10::ms);
  adsrr.set(1::ms, 10::ms, .00001, 10::ms);

  adsrl.setCurves(2.0, 2.0, .5);
  adsrr.setCurves(2.0, 2.0, .5);

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

}

STPADSR stpadsr;
<<<<<<< HEAD
stpadsr.set(5::ms /* Attack */,7 *  10::ms /* Decay */, .6 /* Sustain */, 5*10::ms /* Sustain dur */,  100::ms /* release */);
stpadsr.setCurves(.5, .7, .5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
=======
stpadsr.set(0::ms /* Attack */, 24::ms /* Decay */, .6 /* Sustain */, 10::ms /* Sustain dur */,  10::ms /* release */);
stpadsr.setCurves(2, .7, .5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
>>>>>>> 9aaa7c6e4df36f7a1700bc52f4b3f205f86aeb65
stpadsr.connect(last $ ST, s.note_info_tx_o);


while(1) {
       100::ms => now;
}
 
