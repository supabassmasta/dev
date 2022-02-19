public class KIK extends SYNT{

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

  0 => int spork_cnt;

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

  
  0 => int ongoing;
2::ms => dur stop_dur;


   fun void  trig_freq  (){ 

    // Attack
    if ( ongoing) {
      stop_dur => now;
    }

    spork_cnt => int own_cnt;
    initfe => fe.value;

    for (0 => int i; i <  freqValue.size() &&  spork_cnt == own_cnt  ; i++) {
      freqValue[i] =>  fe.target;
      freqDur[i] => fe.duration  => now;
    }
     
     
  } 
 
  fun void  trig_env  (){ 
    //    <<<"TRIG">>>;
    spork_cnt => int own_cnt;


    // Attack
    if ( ongoing) {
      0 => ge.target;
      stop_dur => ge.duration => now;
    }

    initfg => ge.value;
    initSinPhase => sin0.phase;

    1=> ongoing;
    for (0 => int i; i <  gainValue.size() &&  spork_cnt == own_cnt ; i++) {
      gainValue[i] =>  ge.target;
      gainDur[i] => ge.duration  => now;
    }
    0=> ongoing;
 
  }

  //fun void on()  { }  fun void off() { }  
  
  fun void new_note(int idx)  {
        1 +=> spork_cnt;
        spork ~ trig_freq();
        spork ~ trig_env();
  }
  
  1 => own_adsr;
} 


