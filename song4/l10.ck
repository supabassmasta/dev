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
      adsrop[i].set(1::ms, 20::ms, .7 , 200::ms);
      1 => adsrop[i].gain;
      i++;

      //---------------------
      opin[i] => osc[i] => adsrop[i] => opout[i];
      1./4. + 0.00 => opin[i].gain;
      adsrop[i].set(10::ms, 100::ms, .1 , 200::ms);
      100 * 1 => adsrop[i].gain;
      i++;

      //---------------------
      opin[i] => osc[i] => adsrop[i] => opout[i];
      1./8. +0.03 => opin[i].gain;
      adsrop[i].set(100::ms, 186::ms, .8 , 1800::ms);
      800 => adsrop[i].gain;
      i++;

      //---------------------
      opin[i] => SawOsc s1 => adsrop[i] => opout[i];
      1./8. +0.02=> opin[i].gain;
      adsrop[i].set(500::ms, 700::ms, .001 , 400::ms);
      17 * 10 => adsrop[i].gain;
      i++;

      //---------------------
      opin[i] => osc[i] => adsrop[i] => opout[i];
      2. => opin[i].gain;
      adsrop[i].set(1::ms, 20::ms, .7 , 200::ms);
      1 => adsrop[i].gain;
      .3 => osc[i].gain;
      i++;

      // connect operators
      // main osc
      in => opin[0]; opout[0]=> out; 

      // modulators
      in => opin[1];
      opout[1] => opin[0];

      in => opin[2];
      opout[2] => opin[1];

      in => opin[3];
      opout[3] => opin[0];

      in => opin[4]; 
      opout[4]=> out;
      opout[1] => opin[4];
      opout[3] => opin[4];


      .5 => out.gain;

      fun void on()  
      {
          for (0 => int i; i < 8      ; i++)
          {
              adsrop[i].keyOn();
              // 0=> osc[i].phase;
          }
                
      } 
          
          fun void off() 
          {
              for (0 => int i; i < 8      ; i++) 
              {
                  adsrop[i].keyOff();
              }
                          
                                
          } 
              
              fun void new_note(int idx)  
              { 
                         
              }
}  


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();
t.aeo(); //t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 {6 1_36 0_AB __37 8_54 _AD_" => t.seq;

t.adsr[0].set(10::ms, 50::ms, 0.8, 700::ms);
 t.element_sync(); //t.no_sync(); t.full_sync();     //t.print();
 t.mono() => Gain fb => dac;
 fb => Delay d => fb;
 .8 => d.gain;
 400::ms => d.max => d.delay;

    
 //t.left() => dac.left; t.right() => dac.right; t.raw => dac;
t.go(); 

while(1) {
       100::ms => now;
}
 
