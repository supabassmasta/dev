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
      adsrop[i].set(1::ms, 500::ms, .0001 , 200::ms);
      1 => adsrop[i].gain;
      i++;

      //---------------------
      opin[i] => SawOsc os1 => adsrop[i] => opout[i];
      1./7. + 0.05 => opin[i].gain;
      adsrop[i].set(1::ms, 50::ms, .1 , 200::ms);
      100 * 3 => adsrop[i].gain;
      i++;

      //---------------------
      opin[i] => osc[i] => adsrop[i] => opout[i];
      1./2. +0.0 => opin[i].gain;
      adsrop[i].set(10::ms, 186000::ms, 1 , 1800::ms);
      10 * 3 => adsrop[i].gain;
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
       opout[2] => opin[0];

      in => opin[3];
      // opout[3] => opin[0];


      .3 => out.gain;

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
t.reg(synt0 s1); t.reg(synt0 s2); //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();t.aeo(); t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{6 }c }c" => t.seq;
" (93 _)97_ (4 5_ )2 1 _ " => t.seq;
"*4 (91_ )9|5_ (21_ )2|5_(41_ )4|5_(61_ )6|5_(91_ )9|5_ " => t.seq; 
":4  (93 _)97_ *4 (01_|1_|11____ " => t.seq;
"  ___1___)6B______(54_)93______(5d_______)2a_______(95)9_|5(95______)56__(56__ " => t.seq;
 t.element_sync(); //t.no_sync(); t.full_sync();     //t.print();
// t.mono() => dac; t.left() => dac.left; t.right() => dac.right; t.raw => dac;
 t.left() => Gain fb => dac.left;
 fb => Delay d => fb;
 .5 => d.gain;
 8* data.tick => d.max => d.delay;
 t.right() => Gain fbr => dac.right;
 fbr => Delay dr => fbr;
 .5 => dr.gain;
 8* data.tick => dr.max => dr.delay;


t.go(); 


while(1) {
       100::ms => now;
}
 

