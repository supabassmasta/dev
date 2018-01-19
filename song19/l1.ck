class HPSYBASS0 extends SYNT{

    1 => own_adsr;
    

    inlet => PowerADSR padsrin => TriOsc s => LPF filter =>PowerADSR padsrout => outlet;   
    
    1.0 => s.width;

    .25 => padsrin.gain;
    padsrin.set(0::ms, data.tick/3  , .7 , 200::ms);
    padsrin.setCurves(.6, 7., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

    padsrout.set(1::ms, data.tick/4, .000001 , 200::ms);
    padsrout.setCurves(.6, 2., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
        1.8 => s.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(1::ms, data.tick / 4 , .0000001, data.tick / 4);
    padsr.setCurves(.3, 2.0, .5);
    1 => filter.Q;
    48 => base.next;
    150 => variable.next;

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


            fun void on()  {padsr.keyOn(); padsrin.keyOn(); padsrout.keyOn(); 0.5 => s.phase;}  fun void off() {padsr.keyOff(); padsrin.keyOff(); padsrout.keyOff(); }  fun void new_note(int idx)  {   } 0 => own_adsr;
}

TONE t;
t.reg(HPSYBASS0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
_!1!1!1 _!1!1!1 
_!1!1!1 _!1!1!1 
_!1!1!1 _!1!1!1 
_!1!1!1 _!1!1!1 
_!5!5!1 _!1!5!1 
_!1!1!1 _!1!1!1 
_!1!1!1 _!1!1!1 
_!0!3!1 _!1!5!1 


" => t.seq;
.8 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last;

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

STBREAK stbreak;
stbreak.connect(last $ ST, 0 /* break_number, max 3 */);   stbreak $ ST @=>last; 
// To add in break script
//Break.stbreak_set(0) @=> s.action["a"];  "" => s.wav["a"]; 
//Break.stbreak_release(0) @=> s.action["b"]; "" => s.wav["b"];
// Release a break : Break.release(0); 

while(1) {
       100::ms => now;
}
 
