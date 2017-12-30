public class DUBBASS3 extends SYNT{

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
