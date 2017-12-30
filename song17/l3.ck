class DUBBASS0 extends SYNT{

    inlet => Gain ing => SinOsc s => ABSaturator sat   => LPF filter => outlet;    
    .7 => sat.drive;
    0.2 => sat.dcOffset; 
        4.8 => s.gain;


    .5 => ing.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(data.tick / 4 , data.tick / 4 , .9, data.tick / 4);
    padsr.setCurves(.7, 2.0, .5);
    1 => filter.Q;
    102 => base.next;
    170 => variable.next;

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

            fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  {padsr.keyOn();   }
} 


class DUBBASS1 extends SYNT{

    inlet => Gain ing => SinOsc s => ABSaturator sat   => LPF filter => outlet;    
    .5 => sat.drive;
    0.1 => sat.dcOffset; 
        6.8 => s.gain;


    .25 => ing.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(data.tick / 4 , data.tick / 4 , .9, data.tick / 4);
    padsr.setCurves(.7, 2.0, .5);
    1 => filter.Q;
    102 => base.next;
    170 => variable.next;

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

            fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  {padsr.keyOn();   }
} 

class DUBBASS2 extends SYNT{

    inlet => Gain ing => SqrOsc s => ABSaturator sat   => LPF filter => outlet;    
    .1 => sat.drive;
    0.2 => sat.dcOffset; 
        3.8 => s.gain;
        .35 => s.width;


    .25 => ing.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(data.tick / 4 , data.tick / 4 , .8, data.tick / 4);
    padsr.setCurves(.7, 2.0, .5);
    2 => filter.Q;
    102 => base.next;
    170 => variable.next;

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

            fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  {padsr.keyOn();   }
}

class DUBBASS3 extends SYNT{

    inlet => Gain ing => SqrOsc s => ABSaturator sat   => LPF filter => outlet;    
    .1 => sat.drive;
    0.2 => sat.dcOffset; 
        2.8 => s.gain;
        .35 => s.width;


    .5 => ing.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(data.tick / 4 , data.tick / 4 , .8, data.tick / 4);
    padsr.setCurves(.7, 2.0, .5);
    2 => filter.Q;
    102 => base.next;
    170 => variable.next;

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

            fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  {padsr.keyOn();   }
}

TONE t;
t.reg(DUBBASS3 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
111_ 1___ 1_1_ 1___ 
111_ 0_0_ 1_1_ 1_1_
555_ 1___ 1_1_ 1___
111_ 0_0_ 1_1_ 1_1_
" => t.seq;
.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last;

while(1) {
       100::ms => now;
}


