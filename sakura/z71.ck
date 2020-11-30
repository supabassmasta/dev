
class WAIT {

  class END extends end { 
    0 => int trigged;
    1::ms => dur fixed_dur;    
    fun void kill_me () {
      <<<"Wait THE END">>>;  
      1 => trigged;
      fixed_dur => now;  
      <<<"Wait THE real END">>>;   
    }
  }

  END the_end;
  me.id() => the_end.shred_id; killer.reg(the_end);  

  fun void fixed_end_dur(dur d){
    d => the_end.fixed_dur;
  }

  fun void wait(dur d) {
    d => now;
    if(the_end.trigged) {
      // END ongoing don't get out of wait until Real end
      while(1) {
        10000::ms => now;
      }
    }
  }

}


fun void SNR() {

  SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
  SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
  // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
  "s___ ____" => s.seq;
  .3 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
  s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
  // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
  //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
  s.go();     s $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, 11);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  6 * data.tick => now;


}

  class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
    .1 => s.gain;

    fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
  } 

fun void BLIP () {


  TONE t;
  t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
  t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
  // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
  "}c *8 4103124801234 :8 ____ ____" => t.seq;
  .3 * data.master_gain => t.gain;
  t.sync(1*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
  // t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
  //t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
  //t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
  t.go();   t $ ST @=> ST @ last; 

  STMIX stmix;
  stmix.send(last, 11);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  4 * data.tick => now;


}






///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////

STMIX stmix;
//stmix.send(last, 11);
stmix.receive(11); stmix $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 



WAIT w;
4 *data.tick => w.fixed_end_dur;

while(1) {
  spork ~ SNR();
  2 * data.tick =>  w.wait;
 spork ~ BLIP();
  2 * data.tick =>  w.wait;
}
 


