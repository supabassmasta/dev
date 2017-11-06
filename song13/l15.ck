class synt0 extends SYNT{

    inlet => SinOsc s => ABSaturator sat   => LPF filter => outlet;    
    .0 => sat.drive;
    0.0 => sat.dcOffset; 
        2.8 => s.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(data.tick / 8 , data.tick / 4 , .9, data.tick / 4);
    padsr.setCurves(2.0, 2.0, .5);
    1 => filter.Q;
    48 => base.next;
    4 *100 => variable.next;

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
t.reg(synt0 s1);  //data.tick * 8 => t.max; 
30::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" {c{c *4  
111!888!11 3333333_   555_5588 4444C4C4
111!888!11 444!CCC!44 BB11111_ 88881818
" => t.seq;
.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, .8, 400::ms);
t.adsr[0].setCurves(.8, .5, .5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

while(1) {
       100::ms => now;
}
 
