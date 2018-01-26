public class DUBBASS0 extends SYNT{
    1 => own_adsr;


    inlet => Gain ing => SinOsc s => ABSaturator sat   => LPF filter => ADSR a => outlet;    
    .7 => sat.drive;
    0.2 => sat.dcOffset; 
        4.8 => s.gain;

    a.set(10::ms, 10::ms, 1., 20::ms);


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

            fun void on()  {a.keyOn(); }  fun void off() {padsr.keyOff();a.keyOff(); }  fun void new_note(int idx)  {padsr.keyOn();   }
} 


