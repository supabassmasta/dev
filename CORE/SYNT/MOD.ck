class MOD extends SYNT{

    inlet => Gain in;
    Gain out =>  outlet;   

    0 => int i;
    Gain opin[8];
    Gain opout[8];
    ADSR adsrop[8];
    SinOsc osc[8];
    
    // build and config operators
    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1. => opin[i].gain;
    adsrop[i].set(1::ms, 20::ms, .7 , 200::ms);
    1 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./2. + 0.00 => opin[i].gain;
    adsrop[i].set(10::ms, 100::ms, .1 , 200::ms);
    100 * 3 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./8. +0.0 => opin[i].gain;
    adsrop[i].set(100::ms, 186::ms, .5 , 1800::ms);
    8 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./2. +0.000 => opin[i].gain;
    adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
    30 => adsrop[i].gain;
    i++;

    // connect operators
    // main osc
    in => opin[0]; opout[0]=> out; 

    // modulators
    in => opin[1];
    opout[1] => opin[0];

    in => opin[2];
//    opout[2] => opin[0];

    in => opin[3];
//    opout[3] => opin[0];


    .5 => out.gain;

    fun void on()  {
        for (0 => int i; i < 8      ; i++) {
          adsrop[i].keyOn();
//          0=> osc[i].phase;
        }
      
      } 
    
    fun void off() {
        for (0 => int i; i < 8      ; i++) {
          adsrop[i].keyOff();
        }
            
      
      } 
    
    fun void new_note(int idx)  { 
         
      }
} 

