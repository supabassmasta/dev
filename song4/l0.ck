class synt0 extends SYNT{

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
    adsrop[i].set(100::ms, 200::ms, .5 , 200::ms);
    1 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => TriOsc o1 => adsrop[i] => opout[i];
    .25 => opin[i].gain;
    adsrop[i].set(104::ms, 186::ms, .1 , 200::ms);
    300 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./9. +0.006 => opin[i].gain;
    adsrop[i].set(500::ms, 186::ms, .1 , 1800::ms);
    100 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./2. +0.000 => opin[i].gain;
    adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
    300 => adsrop[i].gain;
    i++;

    // connect operators
    // main osc
    in => opin[0]; opout[0]=> out; 

    // modulators
    in => opin[1];
    opout[1] => opin[0];

    in => opin[2];
    opout[2] => opin[0];

    in => opin[3];
    opout[3] => opin[0];


    .5 => out.gain;

    fun void on()  { } 
    
    fun void off() {
        for (0 => int i; i < 8      ; i++) {
          adsrop[i].keyOff();
        }
            
      
      } 
    
    fun void new_note(int idx)  { 
        for (0 => int i; i < 8      ; i++) {
          adsrop[i].keyOn();
        }
         
      }
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();
t.adsr[0].set(10::ms, 10::ms, .8, 1500::ms);
t.dor();//t.aeo(); t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":21_3_5_7_" => t.seq;
 t.element_sync(); //t.no_sync(); t.full_sync();     //t.print();
// t.mono() => dac; t.left() => dac.left; t.right() => dac.right; t.raw => dac;
t.go(); 

while(1) {
       100::ms => now;
}
 
