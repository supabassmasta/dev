class synt0 extends SYNT{

  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  TriOsc s[synt_nb];
  Gain final =>LPF filter => outlet; .3 => final.gain;

  inlet => detune[i] => s[i] => final; .985 => s[i].width;  1.0012 => detune[i].gain;    .6 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; .985 => s[i].width;  .9991 => detune[i].gain;    .6 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; .885 => s[i].width;  1.0023 => detune[i].gain;    .6 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; .885 => s[i].width;  .9984 => detune[i].gain;    .6 => s[i].gain; i++;  

  inlet => detune[i] => s[i] => final; .985 => s[i].width;  2.0012 => detune[i].gain;    .6 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; .985 => s[i].width;  1.9991 => detune[i].gain;    .6 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; .885 => s[i].width;  2.0023 => detune[i].gain;    .6 => s[i].gain; i++;  
  inlet => detune[i] => s[i] => final; .885 => s[i].width;  1.9984 => detune[i].gain;    .6 => s[i].gain; i++;  




  // Filter to add in graph
  // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
  Step base => Gain filter_freq => blackhole;
  Step variable => PowerADSR padsr => filter_freq;

  // Params
  padsr.set(data.tick / 2 , data.tick / 4 , 1. , data.tick / 4);
  padsr.setCurves(.8, 2.0, .5);
  2 => filter.Q;
  48 => base.next;
  22 * 101 => variable.next;

  // ADSR Trigger
  //padsr.keyOn(); padsr.keyOff();

  // fun void auto_off(){
  //     data.tick / 4 => now;
  //     padsr.keyOff();
  // }
  // spork ~ auto_off();

  fun void filter_freq_control (){ 
    while(1) {
      filter_freq.last() => filter.freq;
      1::ms => now;
    }
  } 
  spork ~ filter_freq_control (); 



  fun void on()  {padsr.keyOn();
    for (0 => int i; i < 8       ; i++) {
      0 => s[i].phase;
    }
  }  

  fun void off() {padsr.keyOff(); }  

  fun void new_note(int idx)  {  padsr.keyOn();

    for (0 => int i; i < 8       ; i++) {
      0 => s[i].phase;

    }


  }

} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c *6 1_1_1_ ______
{c1_1_1_ ______

" => t.seq;
.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

while(1) {
       100::ms => now;
}
 
