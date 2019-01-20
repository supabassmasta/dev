class DUBBASSx extends SYNT{
    1 => own_adsr;


    inlet => Gain ing => SinOsc s /*=> ABSaturator sat  */ => LPF filter => ADSR a => outlet;    
ing => TriOsc s2 /*=> ABSaturator sat  */ => filter;
//    .1 => sat.drive;
//    0.0 => sat.dcOffset; 
        .5 => s.gain;
        .1=> s2.gain;
        .45 => s2.width;

    a.set(10::ms, 10::ms, 1., 300::ms);


    .5 => ing.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(data.tick / 4 , data.tick / 4 , .7, data.tick * 4);
    padsr.setCurves(.7, 2.0, .5);
    1 => filter.Q;
    92 => base.next;
    155 => variable.next;

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

            fun void on()  {padsr.keyOn();a.keyOn(); }  fun void off() {padsr.keyOff();a.keyOff(); }  fun void new_note(int idx)  {padsr.keyOn();   }
} 

TONE t;
t.reg(DUBBASSx s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
1_1_ 1___ 44__ 55__
____ ____ 33__  22__
1_1_ 1___ 44__ 55__
____ ____ ____ ____
" => t.seq;
.15 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //
t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(5::ms, 60::ms, .8, 1400::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STREV2 rev;
rev.connect(last $ ST, .06 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
