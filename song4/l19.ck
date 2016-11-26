
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
  // opout[2] => opin[0];

  in => opin[3];
  // opout[3] => opin[0];


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


  fun void f1 (){ 
    SIN si;
    .125 => si.freq;
    while(1) {
    
//      si.value() * 4 *100 +  100 * 5 => adsrop[1].gain;
//      Math.sin((now/1::second) * 2 * pi/ 4) * 2 *100 +  100 * 3 => adsrop[1].gain;


      10::ms => now;
    }

  } 
  spork ~ f1 ();


}  

class synt1 extends SYNT{

    inlet => TriOsc s =>  outlet;   
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();t.aeo(); t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c *4  1!111!"=> t.seq;
"51!131!15!575!5"=> t.seq;
":2 !1_8/1 " => t.seq;


// t.element_sync(); t.no_sync(); t.full_sync();     //t.print();
 t.mono() => Dyno dy => dac; //
//t.left() => dac.left; t.right() => dac.right; t.raw => dac;
t.go(); 

dy.duck();
.2 => dy.slopeAbove;
2::ms => dy.attackTime;
30::ms => dy.releaseTime;
.04 => dy.thresh;

SEQ s;  data.tick * 4 => s.max;  // SET_WAV.DUBSTEP(s);
 SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4 +++ k|n_k|n_k|nk|n__k|n__s" => s.seq;
// s.element_sync(); //s.no_sync(); //s.full_sync();     //s.print();
 s.mono() => Gain indy => dac; 
// s.mono() => Gain indy => blackhole; 
 //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

fun void f1 (){ 
    indy => Gain indy2 => blackhole;
    9=> indy2.gain;    

while(1) 
{
  indy2.last() =>  dy.sideInput;
       1::samp => now;
}
 
   } 
   spork ~ f1 ();
    



while(1) {
       100::ms => now;
}
 
