class synt0 extends SYNT{
      inlet => Gain in;
      Gain out =>  outlet;   

      0 => int i;
      Gain opin[8];
      Gain opout[8];
      ADSR adsrop[8];
      TriOsc osc[8];

      // build and config operators
      //---------------------
      opin[i] => osc[i] => adsrop[i] => opout[i];
      1. => opin[i].gain;
      adsrop[i].set(1::ms, 20::ms, 1. , 2::ms);
      1 => adsrop[i].gain;
      i++;

      //---------------------
      opin[i] => osc[i] => adsrop[i] => opout[i];
      1./2. + 0.0 => opin[i].gain;
      adsrop[i].set(10::ms, 100::ms, 1. , 200::ms);
      100 * 30 => adsrop[i].gain;
      i++;

      //---------------------
//      opin[i] =>;
      Step st => osc[i] => adsrop[i] => opout[i];
      4::second / 2::data.tick => st.next;
      1./8. +0.0 => opin[i].gain;
      adsrop[i].set(100::ms, 186::ms, 1. , 1800::ms);
      4 * 100 => adsrop[i].gain;
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
//      opout[3] => opin[0];


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
                 
                 if(idx == 0){
                   
//                   0.2 => osc[2].phase;        
//                   <<<"PHASE UPDATE">>>;
}
              }
               0 => own_adsr;
}  







TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  //
//t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4*2 }c}c}c
1_3_ 5___ 8___ __B_
5___ __8_ ____ B_B_
1_3_ 5___ 8_8_ __A_
6_6_ __6_ ____ ____
" => t.seq;
0.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


//==============================================================================================
STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 8 , .3);  ech $ ST @=>  last; 

//STFILTERMOD fmod;
//fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 600 /* f_base */ , 400  /* f_var */, 1::second / (12 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


STLPF lpf;
lpf.connect(last $ ST , 14 * 100 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STCOMPRESSOR stcomp;
4. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 



