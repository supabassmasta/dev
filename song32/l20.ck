
class KIKA extends SYNT{

    // inlet 
  Step stp0 =>  Envelope fe =>  SinOsc sin0 =>  Envelope ge => outlet; 
  1.0 => stp0.next;
  0.0 => ge.value;
  1.0 => sin0.gain;
  
  float initSinPhase;
  float initfe;
  float initfg;

  float freqValue [0];
  dur freqDur [0];
  float gainValue [0];
  dur gainDur [0];

  fun void  addFreqPoint (float f, dur d){ 
     freqValue << f;
     freqDur << d;
  } 

  fun void  addGainPoint (float g, dur d){ 
     gainValue << g;
     gainDur << d;
  } 


  fun void  config  (float p, float ife, float ifg){ 
    p => initSinPhase;
    ife => initfe;
    ifg => initfg;
  } 

  

   fun void  trig_freq  (){ 
    initfe => fe.value;

    for (0 => int i; i <  freqValue.size() ; i++) {
      freqValue[i] =>  fe.target;
      freqDur[i] => fe.duration  => now;
    }
     
     
  } 
 
  fun void  trig_env  (){ 
//    <<<"TRIG">>>;

    initSinPhase => sin0.phase;

    // Attack
    initfg => ge.value;

    for (0 => int i; i <  gainValue.size() ; i++) {
      gainValue[i] =>  ge.target;
      gainDur[i] => ge.duration  => now;
    }
 
  }

  //fun void on()  { }  fun void off() { }  
  
  fun void new_note(int idx)  {
        spork ~ trig_freq();
        spork ~ trig_env();
  }
  
  1 => own_adsr;

class ACT extends ACTION {
    fun int on_time() {
          <<<"test">>>; 
          new_note( 0); }
}

ACT act; 


} 

KIKA kik;
kik.config(0.1 /* init Sin Phase */, 76 * 100 /* init freq env */, 0.4 /* init gain env */);
kik.addFreqPoint (233.0, 2::ms);
kik.addFreqPoint (100.0, 20::ms);
kik.addFreqPoint (35.0, 17 * 10::ms);

kik.addGainPoint (0.6, 2::ms);
kik.addGainPoint (0.3, 10::ms);
kik.addGainPoint (1.0, 10::ms);
kik.addGainPoint (1.0, 171::ms);
kik.addGainPoint (0.0, 15::ms); 

