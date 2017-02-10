class synt0 extends SYNT{
      inlet => Gain in;
      Gain out => LPF lpf =>  outlet;   
      500 => lpf.freq;  
      2 => lpf.Q;

      0 => int i;
      Gain opin[8];
      Gain opout[8];
      ADSR adsrop[8];
      SinOsc osc[8];

      // build and config operators
      //---------------------
      opin[i] => SqrOsc sqr => adsrop[i] => opout[i];
      1. => opin[i].gain;
      adsrop[i].set(1::ms, 20::ms, .7 , 200::ms);
      1 => adsrop[i].gain;
      i++;

      .42 => sqr.width;  

      //---------------------
      opin[i] => osc[i] => adsrop[i] => opout[i];
      1. => opin[i].gain;
      adsrop[i].set(1::ms, 20::ms, .7 , 200::ms);
      1 => adsrop[i].gain;
      i++;

      //---------------------
      opin[i] => osc[i] => adsrop[i] => opout[i];
      1./2. +0.0 => opin[i].gain;
      adsrop[i].set(1::ms, 88::ms, .005 , 100::ms);
      4 * 10  => adsrop[i].gain;
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
      in => opin[1]; opout[1]=> out; 
//      in => opin[1];
//      opout[1] => opin[0];

      in => opin[2];
      opout[2] => opin[0];

      in => opin[3];
      // opout[3] => opin[0];


      .4 => out.gain;

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
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); 
t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//" *4 !0!0!0!0!0!0!0!5!0!0!7!0!3!4" => t.seq;
" *4 1_1_ ____ _4!4_ ____" => t.seq;
"    ____ 8//0__ _0_2 __2_" => t.seq;
//" *4 _0_0 _0!0!0" => t.seq;
//"    _4_0 _0!5!0" => t.seq;
.9 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

//STDUCK duck;
//duck.connect(t $ ST); 


while(1) {
       100::ms => now;
}
 
